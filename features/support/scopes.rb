module ScopeHelpers
  # Maps a name to a scope.
  def scope_to(scope_name)
    case scope_name

    when /within tags/
      ".tags input[type=text]"

    else
      raise %{Can't find mapping from "#{scope_name}" to a scope.}
    end
  end
end

World(ScopeHelpers)
