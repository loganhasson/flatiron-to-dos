require_relative './binary_handshake'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :progress # :progress, :html, :textmate
end

describe 'SecretHandshake' do 
  it 'should know how to wink with a 1' do
    handshake = SecretHandshake.new("1")
    handshake.commands.should eq(["wink"])
  end    

  it 'should know how to double blink with a 10' do
    handshake = SecretHandshake.new("10")
    handshake.commands.should eq(["double blink"])
  end

  it 'should know how to close your eyes with 100' do
    handshake = SecretHandshake.new("100")
    handshake.commands.should eq(["close your eyes"])
  end

  it 'should know to jump with 1000' do
    handshake = SecretHandshake.new("1000")
    handshake.commands.should eq(["jump"])
  end

  it 'should know to wink double blink with 11' do
    handshake = SecretHandshake.new("11")
    handshake.commands.should eq(["wink","double blink"]) 
  end

  it 'should know to double blink, wink, with 10011' do
    handshake = SecretHandshake.new("10011")
    handshake.commands.should eq(["double blink","wink"])
  end

  it 'should get this complicated handshake correctly' do
    handshake = SecretHandshake.new("11111")
    handshake.commands.should eq(["jump","close your eyes","double blink","wink"])
  end

  it 'should not respond to an invalid code' do
    handshake = SecretHandshake.new("binary")
    handshake.commands.should eq([])
  end
end