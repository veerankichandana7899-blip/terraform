resource "aws_lambda_layer_version" "example" {
  filename         = "layer.zip"
  layer_name       = "python_shared_layer"
  source_code_hash = filebase64sha256("layer.zip")
  compatible_runtimes = ["python3.12"]
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_basic_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "example" {
  function_name = "layer-test-lambda"
  runtime       = "python3.12"
  handler       = "app.handler"
  role          = aws_iam_role.lambda_role.arn

  filename         = "app.zip"
  source_code_hash = filebase64sha256("app.zip")

  layers = [aws_lambda_layer_version.example.arn]
}
