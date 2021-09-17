class Disassembler
  def self.disassemble(logger, src, cache_manager)
    out = StringIO.new
    $stderr = out
    begin
      cached = cache_manager&.get_cached(src)
      unless cached.nil?
        logger.info 'cache hit'
        return cached
      end

      logger.info 'cache miss'
      diss = RubyVM::InstructionSequence.compile(src).disassemble
      cache_manager&.set_cached(src, diss)

      return diss
    rescue StandardError => e
      logger e.message
      out.string
    end
  end
end
