$ErrorActionPreference = "Stop"

if ($args.length -ne 1)
{
	Write-Host "usage: $PSCommandPath FILENAME[:LINENO][:IGNORED]"
	exit 1
}

$input = $args[0].Split(":")
$file = $input[0]
$center = $input[1]

if ($center.Length -eq 0)
{
	$center = 0
}
else
{
	$center = [int]$center
}

if (-not (Test-Path $file -PathType Leaf))
{
	echo "File not found $file"
	exit 1
}

# TODO: Check if $file is binary. If so:
#   echo mimetype
#   exit 0

$lines = 40
if ($env:FZF_PREVIEW_LINES)
{
	$lines = [int]$env:FZF_PREVIEW_LINES
}

$first = $center - [int]($lines / 3)
if ($first -lt 1)
{
	$first = 1
}

$last = $first + $lines - 1

if (Get-Command -CommandType Application -ErrorAction SilentlyContinue bat)
{
	$style = "numbers"
	if ($env:BAT_STYLE)
	{
		$style = $env:BAT_STYLE
	}

	bat --style=$style --color=always --pager=never `
		--line-range=${first}:$last --highlight-line=$center $file
	exit $LASTEXITCODE
}
else
{
	$result = Get-Content $file
	$result[$first..$last]
}
