class AnalyzeResume
  def initialize(text)
    @text = text
  end

  def analyze
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'], log_errors: true)
    prompt = <<~PROMPT
      You are an ATS (Applicant Tracking System) expert. Analyze the following resume text and return a JSON object with:
      - ats_score: integer 0-100
      - strengths: array of strings (length 5)
      - weaknesses: array of strings (length 5)
      - improvements: array of strings (actionable improvements) (length 5)

      Resume text:
      #{@text}
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-5-nano",
        messages: [{ role: "user", content: prompt }],
        response_format: { type: "json_object" }
      }
    )

    content = response.dig("choices", 0, "message", "content")
    JSON.parse(content)
  rescue => e
    { error: e.message }
  end
end