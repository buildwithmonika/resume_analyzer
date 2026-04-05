class HomeController < ApplicationController

    def index
    end

    def analyze_resume
        # puts (params.inspect)
        resume = params[:resume]
        puts "resume - #{resume.inspect}"
        if resume.present?
            text = extract_text(resume)
            puts "text - #{text.inspect}"
        else
            puts "No file uploaded"
        end
    end

    private

    def extract_text(resume)
        content_type = resume.content_type
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
