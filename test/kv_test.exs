defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "spawns registry" do
    assert KV.Registry.lookup(KV.Registry, "shopping") == :error

    KV.Registry.create(KV.Registry, "shopping")
    assert {:ok, bucket} = KV.Registry.lookup(KV.Registry, "shopping")

    KV.Bucket.put(bucket, "milk", 1)
    assert KV.Bucket.get(bucket, "milk") == 1
  end
end
