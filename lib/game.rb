module Tetris
  class Game
    attr_reader :status
    attr_accessor :banner

    def initialize(titler = Proc.new {})
      @titler = titler
      @pause_title = @titler.call(nil)
      @status = :started
    end

    def toggle
      if started?
        pause
      else
        unpause
      end
    end

    def pause
      @status = :paused
      @pause_title = @titler.call("Paused")
    end

    def unpause
      @status = :started
      @pause_title.remove
    end

    def started?
      @status == :started
    end

    def paused?
      @status == :paused
    end
  end
end
