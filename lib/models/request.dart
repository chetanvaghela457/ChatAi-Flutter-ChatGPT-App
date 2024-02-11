class GPTRequestOpenAiModel {
  String model;
  String prompt;
  int temperature;
  int max_tokens;

  GPTRequestOpenAiModel(
      {this.model, this.prompt, this.temperature, this.max_tokens});

  factory GPTRequestOpenAiModel.fromJson(Map<String, dynamic> json) =>
      GPTRequestOpenAiModel(
        model: json["model"],
        prompt: json["prompt"],
        temperature: json["temperature"].toInteger(),
        max_tokens: json["max_tokens"].toInteger()
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": max_tokens,
      };
}