# Compatibility shim for environments with older RubyGems that do not
# provide Gem::Platform.match (needed by tailwindcss-rails during precompile).
unless Gem::Platform.respond_to?(:match)
  class << Gem::Platform
    def match(platform)
      Gem::Platform.local === platform
    end
  end
end
