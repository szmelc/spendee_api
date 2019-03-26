# frozen_string_literal: true

module StaticFacade
  def call(*args)
    new(*args).call
  end
end
