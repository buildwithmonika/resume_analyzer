class HomeController < ApplicationController


    def index
    end

    def analyze_resume
        allowed_content_types = ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
        resume = params[:resume]
        @response = { error: "No file uploaded." }
        if resume.present?
            content_type = resume.content_type
            if allowed_content_types.include?(content_type)
                text = extract_text(resume, content_type)
                if text.present?
                    @response = AnalyzeResume.new(text).analyze
                else
                    @response = {error: "Could not extract text from file."}
                end
            else
                @response = { error: "Only pdf and doc files are allowed." }
            end
        end

        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: turbo_stream.update("result", partial: "result", locals: { analysis: @response })
            end
        end
    end

    private

    def extract_text(resume, content_type)
        if content_type == 'application/pdf'
            reader = PDF::Reader.new(resume.tempfile)
            puts(reader.pages.inspect)
            reader.pages.map(&:text).join("\n")
        elsif content_type = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            doc = Docx::Document.open(resume.tempfile)
            doc.paragraphs.map(&:text).join("\n")
        else
            ''
        end
    end
end
