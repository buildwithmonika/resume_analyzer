class AnalyzeResume
  def initialize(text)
    @text = text
  end

  def analyze
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'], log_errors: true)
    prompt = <<ENV['OPENAI_ACCESS_TOKEN']      You are an ATS (Applicant Tracking System) expert. Analyze the following resume text and return a JSON object with:
      - ats_score: integer 0-100
      - strengths: array of strings
      - weaknesses: array of strings
      - missing_keywords: array of strings (common keywords missing for a software engineer)
      - suggestions: array of strings (actionable improvements)

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