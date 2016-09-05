#!/usr/bin/env ruby

def disassemble(src)
  out = StringIO.new
  $stderr = out
  begin
    RubyVM::InstructionSequence.compile(src).disassemble
  rescue StandardError => e
    puts e.message
    out.string
  end
end

puts disassemble ARGV[0] if ARGV[0]
