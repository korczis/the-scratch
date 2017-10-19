defmodule TheScratch.Proto do
  @moduledoc """
  Wrapper of protocol buffer messages
  """

  @external_resource Path.wildcard(Path.expand("../../proto/**/*.proto", __DIR__))

  use Protobuf,
      from: Path.wildcard(Path.expand("../../proto/**/*.proto", __DIR__)),
      use_package_names: true,
      inject: true
end


#defprotocol TypeName do
#  @doc ""
#  def type_name(data)
#end
#
#
#defimpl TypeName, for: Fintech.Msg.BlockchainTransaction do
#  def type_name(data), do: "#{data.__struct__}"
#end
