defmodule TheScratch.Helper do
  def debug_mode? do
    System.get_env("MIX_ENV") != "prod"
  end
end
