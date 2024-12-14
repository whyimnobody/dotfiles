# FUNCTIONS
function refresh
{
  if [ -n "$(jobs)" ]; then
    print -P "Error: %j job(s) in background"
  else
    exec zsh
  fi
}
function bootstrap.psql {
	curl -o docker-compose.yml https://gitlab.com/-/snippets/2353106/raw/main/docker-compose.yml && sed -i 's/'$1'/something_creative/' docker-compose.yml
}
function decode.jwt {
	jq -R 'split(".") | .[0] | @base64d | fromjson' <<<"$1" && jq -R 'split(".") | .[1] | @base64d | fromjson' <<<"$1"
}
function format.json {
	pbpaste >"${1:-/tmp/some.json}" && jq . "${1:-/tmp/some.json}"
}


# tmux attach -t completion
_tmux_attach_completion() {
  # Check if the current command is 'tmux attach'
  if [[ "$words[1]" == "tmux" && "$words[2]" == "attach" ]]; then
    # Define the expected options and arguments
    _arguments \
      '-t+[Specify tmux session]:session name:(_tmux_list_sessions)' \
      '*: :_files'
  else
    # Fallback to default completion
    _arguments '*:filename:_files'
  fi
}

# Helper function to list tmux sessions
_tmux_list_sessions() {
  local -a sessions
  # Fetch the list of tmux sessions, handling cases with no sessions
  sessions=("${(@f)$(tmux list-sessions -F '#S' 2>/dev/null)}")
  if (( ${#sessions} )); then
    _describe 'tmux session' sessions
  else
    _message 'No active tmux sessions'
  fi
}

# Associate the completion function with 'tmux attach'
compdef _tmux_attach_completion tmux

