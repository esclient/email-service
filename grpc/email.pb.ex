defmodule Email.EmailTemplate do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :EMAIL_TEMPLATE_UNSPECIFIED, 0
  field :EMAIL_TEMPLATE_VERIFICATION_CODE, 1
end

defmodule Email.EmailTemplateVar do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Email.SendEmailRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :destination_email, 1, type: :string, json_name: "destinationEmail"
  field :template, 2, type: Email.EmailTemplate, enum: true
  field :vars, 3, repeated: true, type: Email.EmailTemplateVar
end

defmodule Email.SendEmailResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :success, 1, type: :bool
end

defmodule Email.EmailService.Service do
  @moduledoc false

  use GRPC.Service, name: "email.EmailService", protoc_gen_elixir_version: "0.15.0"

  rpc :SendEmail, Email.SendEmailRequest, Email.SendEmailResponse
end

defmodule Email.EmailService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Email.EmailService.Service
end
