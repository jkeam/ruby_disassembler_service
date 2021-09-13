class Disassembler
  def self.disassemble(src, cache_manager)
    out = StringIO.new
    $stderr = out
    begin
      cached = cache_manager&.get_cached(src)
      return cached unless cached.nil?

      diss = RubyVM::InstructionSequence.compile(src).disassemble
      cache_manager&.set_cached(src, diss)

      return diss
    rescue StandardError => e
      puts e.message
      out.string
    end
  end
end
