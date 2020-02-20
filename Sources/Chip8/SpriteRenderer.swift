import SGLMath
import SGLOpenGL
import CGLFW3

public class SpriteRenderer {
    private let shader: Shader
    
    private var quadVAO: GLuint = 0
    
    public init(shader: Shader) {
        self.shader = shader
        self.initRenderData()
    }
    
    deinit {
        glDeleteVertexArrays(1, &quadVAO)
    }
    
    public func draw(position: Vector2<GLfloat>, size: Vector2<GLfloat>, rotate: GLfloat, color: Vector3<GLfloat>) {
        shader.use()
        var model = mat4(1.0)
        // position
        model = SGLMath.translate(model, Vector3(position, 0.0))
        
        //rotation
        model = SGLMath.translate(model, Vector3(0.5 * size.x, 0.5 * size.y, 0.0))
        model = SGLMath.rotate(model, rotate, Vector3(0.0, 0.0, 1.0))
        model = SGLMath.translate(model, Vector3(-0.5 * size.x, -0.5 * size.y, 0.0))
        
        //scale
        model = SGLMath.scale(model, Vector3(size, 1.0))
        
        shader.setUniform("model", matrix4x4: model)
        shader.setUniform("spriteColor", vector3: color)
        
        glBindVertexArray(quadVAO)
        glDrawArrays(GL_TRIANGLES, 0, 6)
        glBindVertexArray(0)
    }
    
    private func initRenderData() {
        let vertices: [GLfloat] = [
            0.0, 1.0,
            1.0, 0.0,
            0.0, 0.0,
            0.0, 1.0,
            1.0, 1.0,
            1.0, 0.0
        ]
        
        glGenVertexArrays(n: 1, arrays: &quadVAO)
        
        var VBO: GLuint = 0
        glGenBuffers(n: 1, buffers: &VBO)
        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: VBO)
        glBufferData(target: GL_ARRAY_BUFFER, size: MemoryLayout<GLfloat>.stride * vertices.count, data: vertices, usage: GL_STATIC_DRAW)
            
        glBindVertexArray(quadVAO)
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(index: 0, size: 2, type: GL_FLOAT, normalized: false, stride: GLsizei(MemoryLayout<GLfloat>.stride * 2), pointer: nil)
        
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindVertexArray(0);
    }
}
