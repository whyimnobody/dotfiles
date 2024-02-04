# FUNCTIONS
# ------------------------------------------------------------------------------

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
