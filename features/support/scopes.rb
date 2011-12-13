module ScopeHelpers
  # Maps a name to a scope.
  def scope_to(scope_str)
    case scope_str

    when /tags/
      ".tags"

    else
      raise <<-EOS
Can't find mapping from "#{scope_str}" to a path.
Now, go and add a mapping in #{__FILE__}
      EOS
    end
  end
end

World(ScopeHelpers)
