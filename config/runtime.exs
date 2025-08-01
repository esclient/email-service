import Config
import Dotenvy

source!([".env", System.get_env()])

config :emailservice, EmailService.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: System.fetch_env!("SMTP_RELAY"),
  username: System.fetch_env!("SMTP_USER"),
  password: System.fetch_env!("SMTP_PASS"),
  port: String.to_integer(System.get_env("SMTP_PORT", "25")),
  ssl: false,
  tls: :never,
  auth: :always

config :emailservice, grpc_port: String.to_integer(System.fetch_env!("PORT"))

config :swoosh, :api_client, Swoosh.ApiClient.Finch

config :emailservice,
  from_name: System.fetch_env!("EMAIL_FROM_NAME"),
  from_address: System.fetch_env!("EMAIL_FROM_ADDRESS")
