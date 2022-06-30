defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

#  test "are temporary workers" do
#    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
#  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes value by key", %{bucket: bucket} do
    assert KV.Bucket.delete(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 4)
    assert KV.Bucket.delete(bucket, "milk") == 4
    assert KV.Bucket.delete(bucket, "milk") == nil
  end

  test "do various puts, gets, and deletes", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 1)
    assert KV.Bucket.get(bucket, "milk") == 1
    KV.Bucket.put(bucket, "butter", 2)
    assert KV.Bucket.get(bucket, "butter") == 2
    KV.Bucket.put(bucket, "bread", 3)
    assert KV.Bucket.delete(bucket, "milk") == 1
    assert KV.Bucket.delete(bucket, "butter") == 2
    assert KV.Bucket.delete(bucket, "bread") == 3
    assert KV.Bucket.delete(bucket, "butter") == nil
    assert KV.Bucket.delete(bucket, "sushi") == nil
  end
end
