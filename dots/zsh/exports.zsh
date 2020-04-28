export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export REVIEW_BASE=master
export DIRENV_LOG_FORMAT=
export FZF_TAB_PREFIX=
export FZF_TAB_OPTS=(
    --ansi --color=light --expect='/'
    --nth=2,3 --delimiter='\0'  # Don't search FZF_TAB_PREFIX
    --layout=reverse --height=90%
    --tiebreak=begin -m --bind=tab:down,ctrl-j:accept,change:top,ctrl-space:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="GitHub"

# TODO: Replace this with the actual thing
# https://github.com/sharkdp/vivid
export LS_COLORS='cd=0;38;2;0;0;0;48;2;134;179;0:di=0;38;2;27;125;196:or=0;38;2;0;0;0;48;2;237;102;106:so=0;38;2;0;0;0;48;2;240;113;113:*~=0;38;2;170;170;170:bd=0;38;2;0;0;0;48;2;237;102;106:ln=0;38;2;240;113;113:ex=1;38;2;237;102;106:pi=0;38;2;0;0;0;48;2;27;125;196:fi=0:mi=0;38;2;0;0;0;48;2;237;102;106:no=0:*.t=0;38;2;49;136;102:*.p=0;38;2;49;136;102:*.c=0;38;2;49;136;102:*.a=1;38;2;237;102;106:*.m=0;38;2;49;136;102:*.z=4;38;2;134;179;0:*.r=0;38;2;49;136;102:*.h=0;38;2;49;136;102:*.d=0;38;2;49;136;102:*.o=0;38;2;170;170;170:*.rs=0;38;2;49;136;102:*.ko=1;38;2;237;102;106:*.py=0;38;2;49;136;102:*.ui=0;38;2;237;147;102:*.cp=0;38;2;49;136;102:*.hh=0;38;2;49;136;102:*.go=0;38;2;49;136;102:*.hi=0;38;2;170;170;170:*.cs=0;38;2;49;136;102:*.bz=4;38;2;134;179;0:*.mn=0;38;2;49;136;102:*css=0;38;2;49;136;102:*.js=0;38;2;49;136;102:*.as=0;38;2;49;136;102:*.cc=0;38;2;49;136;102:*.bc=0;38;2;170;170;170:*.di=0;38;2;49;136;102:*.so=1;38;2;237;102;106:*.sh=0;38;2;49;136;102:*.pl=0;38;2;49;136;102:*.cr=0;38;2;49;136;102:*.fs=0;38;2;49;136;102:*.el=0;38;2;49;136;102:*.lo=0;38;2;170;170;170:*.ll=0;38;2;49;136;102:*.td=0;38;2;49;136;102:*.md=0;38;2;237;147;102:*.vb=0;38;2;49;136;102:*.nb=0;38;2;49;136;102:*.gz=4;38;2;134;179;0:*.gv=0;38;2;49;136;102:*.pm=0;38;2;49;136;102:*.ts=0;38;2;49;136;102:*.ex=0;38;2;49;136;102:*.pp=0;38;2;49;136;102:*.rb=0;38;2;49;136;102:*.ps=0;38;2;237;102;106:*.la=0;38;2;170;170;170:*.rm=0;38;2;240;113;113:*.xz=4;38;2;134;179;0:*.ml=0;38;2;49;136;102:*.7z=4;38;2;134;179;0:*.kt=0;38;2;49;136;102:*.jl=0;38;2;49;136;102:*.hs=0;38;2;49;136;102:*.tbz=4;38;2;134;179;0:*.tgz=4;38;2;134;179;0:*.ods=0;38;2;237;102;106:*.erl=0;38;2;49;136;102:*.ppt=0;38;2;237;102;106:*.git=0;38;2;170;170;170:*.clj=0;38;2;49;136;102:*.bz2=4;38;2;134;179;0:*.ipp=0;38;2;49;136;102:*.aux=0;38;2;170;170;170:*.dpr=0;38;2;49;136;102:*.lua=0;38;2;49;136;102:*.htc=0;38;2;49;136;102:*.blg=0;38;2;170;170;170:*.swp=0;38;2;170;170;170:*.dmg=4;38;2;134;179;0:*.rpm=4;38;2;134;179;0:*.asa=0;38;2;49;136;102:*.toc=0;38;2;170;170;170:*.bag=4;38;2;134;179;0:*.xmp=0;38;2;237;147;102:*.cfg=0;38;2;237;147;102:*.nix=0;38;2;237;147;102:*.xlr=0;38;2;237;102;106:*.def=0;38;2;49;136;102:*.fsx=0;38;2;49;136;102:*.bbl=0;38;2;170;170;170:*.bst=0;38;2;237;147;102:*.rar=4;38;2;134;179;0:*.xls=0;38;2;237;102;106:*.sxw=0;38;2;237;102;106:*.fnt=0;38;2;240;113;113:*.inl=0;38;2;49;136;102:*.aif=0;38;2;240;113;113:*.sbt=0;38;2;49;136;102:*.hxx=0;38;2;49;136;102:*.svg=0;38;2;240;113;113:*.zip=4;38;2;134;179;0:*.vim=0;38;2;49;136;102:*.odt=0;38;2;237;102;106:*.tar=4;38;2;134;179;0:*.dox=0;38;2;154;232;69:*.arj=4;38;2;134;179;0:*.swf=0;38;2;240;113;113:*.mp4=0;38;2;240;113;113:*.mir=0;38;2;49;136;102:*.awk=0;38;2;49;136;102:*.tmp=0;38;2;170;170;170:*.txt=0;38;2;237;147;102:*.wav=0;38;2;240;113;113:*.inc=0;38;2;49;136;102:*.mp3=0;38;2;240;113;113:*.pbm=0;38;2;240;113;113:*.xml=0;38;2;237;147;102:*.h++=0;38;2;49;136;102:*.csv=0;38;2;237;147;102:*.elm=0;38;2;49;136;102:*.mid=0;38;2;240;113;113:*.mpg=0;38;2;240;113;113:*.odp=0;38;2;237;102;106:*.wmv=0;38;2;240;113;113:*.idx=0;38;2;170;170;170:*.rst=0;38;2;237;147;102:*.pod=0;38;2;49;136;102:*.epp=0;38;2;49;136;102:*.csx=0;38;2;49;136;102:*TODO=1:*.pro=0;38;2;154;232;69:*.kts=0;38;2;49;136;102:*.pyc=0;38;2;170;170;170:*.log=0;38;2;170;170;170:*.mli=0;38;2;49;136;102:*.tcl=0;38;2;49;136;102:*.jar=4;38;2;134;179;0:*.sql=0;38;2;49;136;102:*.ind=0;38;2;170;170;170:*.otf=0;38;2;240;113;113:*.doc=0;38;2;237;102;106:*.vcd=4;38;2;134;179;0:*.tex=0;38;2;49;136;102:*.exe=1;38;2;237;102;106:*.sxi=0;38;2;237;102;106:*.gvy=0;38;2;49;136;102:*.zsh=0;38;2;49;136;102:*.php=0;38;2;49;136;102:*.pgm=0;38;2;240;113;113:*.out=0;38;2;170;170;170:*.htm=0;38;2;237;147;102:*.bat=1;38;2;237;102;106:*.ico=0;38;2;240;113;113:*.c++=0;38;2;49;136;102:*.cgi=0;38;2;49;136;102:*.bib=0;38;2;237;147;102:*.fon=0;38;2;240;113;113:*.tif=0;38;2;240;113;113:*.mov=0;38;2;240;113;113:*.img=4;38;2;134;179;0:*.dll=1;38;2;237;102;106:*.fsi=0;38;2;49;136;102:*.bcf=0;38;2;170;170;170:*.exs=0;38;2;49;136;102:*.tsx=0;38;2;49;136;102:*.ppm=0;38;2;240;113;113:*.ttf=0;38;2;240;113;113:*.cxx=0;38;2;49;136;102:*.rtf=0;38;2;237;102;106:*.vob=0;38;2;240;113;113:*.yml=0;38;2;237;147;102:*.ilg=0;38;2;170;170;170:*.bsh=0;38;2;49;136;102:*.com=1;38;2;237;102;106:*.png=0;38;2;240;113;113:*.ini=0;38;2;237;147;102:*.fls=0;38;2;170;170;170:*.pid=0;38;2;170;170;170:*.bak=0;38;2;170;170;170:*.sty=0;38;2;170;170;170:*.deb=4;38;2;134;179;0:*.wma=0;38;2;240;113;113:*.ics=0;38;2;237;102;106:*.gif=0;38;2;240;113;113:*.bmp=0;38;2;240;113;113:*.hpp=0;38;2;49;136;102:*.m4v=0;38;2;240;113;113:*.ogg=0;38;2;240;113;113:*.ps1=0;38;2;49;136;102:*.ltx=0;38;2;49;136;102:*.bin=4;38;2;134;179;0:*.pas=0;38;2;49;136;102:*.pkg=4;38;2;134;179;0:*.flv=0;38;2;240;113;113:*.jpg=0;38;2;240;113;113:*.pdf=0;38;2;237;102;106:*.dot=0;38;2;49;136;102:*.avi=0;38;2;240;113;113:*.cpp=0;38;2;49;136;102:*.tml=0;38;2;237;147;102:*hgrc=0;38;2;154;232;69:*.mkv=0;38;2;240;113;113:*.kex=0;38;2;237;102;106:*.xcf=0;38;2;240;113;113:*.pps=0;38;2;237;102;106:*.iso=4;38;2;134;179;0:*.apk=4;38;2;134;179;0:*.lisp=0;38;2;49;136;102:*.less=0;38;2;49;136;102:*.mpeg=0;38;2;240;113;113:*.epub=0;38;2;237;102;106:*.h264=0;38;2;240;113;113:*.html=0;38;2;237;147;102:*.pptx=0;38;2;237;102;106:*.lock=0;38;2;170;170;170:*.bash=0;38;2;49;136;102:*.psd1=0;38;2;49;136;102:*.hgrc=0;38;2;154;232;69:*.make=0;38;2;154;232;69:*.java=0;38;2;49;136;102:*.psm1=0;38;2;49;136;102:*.dart=0;38;2;49;136;102:*.json=0;38;2;237;147;102:*.xlsx=0;38;2;237;102;106:*.tbz2=4;38;2;134;179;0:*.toml=0;38;2;237;147;102:*.yaml=0;38;2;237;147;102:*.rlib=0;38;2;170;170;170:*.flac=0;38;2;240;113;113:*.docx=0;38;2;237;102;106:*.diff=0;38;2;49;136;102:*.purs=0;38;2;49;136;102:*.fish=0;38;2;49;136;102:*.orig=0;38;2;170;170;170:*.jpeg=0;38;2;240;113;113:*.conf=0;38;2;237;147;102:*.cabal=0;38;2;49;136;102:*.shtml=0;38;2;237;147;102:*.dyn_o=0;38;2;170;170;170:*.swift=0;38;2;49;136;102:*shadow=0;38;2;237;147;102:*.mdown=0;38;2;237;147;102:*.scala=0;38;2;49;136;102:*.xhtml=0;38;2;237;147;102:*.toast=4;38;2;134;179;0:*.ipynb=0;38;2;49;136;102:*.patch=0;38;2;49;136;102:*.class=0;38;2;170;170;170:*README=0;38;2;0;0;0;48;2;237;147;102:*passwd=0;38;2;237;147;102:*.cache=0;38;2;170;170;170:*.cmake=0;38;2;154;232;69:*.flake8=0;38;2;154;232;69:*.config=0;38;2;237;147;102:*.gradle=0;38;2;49;136;102:*INSTALL=0;38;2;0;0;0;48;2;237;147;102:*.groovy=0;38;2;49;136;102:*.ignore=0;38;2;154;232;69:*.matlab=0;38;2;49;136;102:*.dyn_hi=0;38;2;170;170;170:*COPYING=0;38;2;102;102;102:*TODO.md=1:*LICENSE=0;38;2;102;102;102:*.desktop=0;38;2;237;147;102:*setup.py=0;38;2;154;232;69:*.gemspec=0;38;2;154;232;69:*Doxyfile=0;38;2;154;232;69:*Makefile=0;38;2;154;232;69:*TODO.txt=1:*.fdignore=0;38;2;154;232;69:*configure=0;38;2;154;232;69:*.cmake.in=0;38;2;154;232;69:*COPYRIGHT=0;38;2;102;102;102:*.kdevelop=0;38;2;154;232;69:*.markdown=0;38;2;237;147;102:*.rgignore=0;38;2;154;232;69:*README.md=0;38;2;0;0;0;48;2;237;147;102:*SConscript=0;38;2;154;232;69:*README.txt=0;38;2;0;0;0;48;2;237;147;102:*Dockerfile=0;38;2;237;147;102:*CODEOWNERS=0;38;2;154;232;69:*SConstruct=0;38;2;154;232;69:*INSTALL.md=0;38;2;0;0;0;48;2;237;147;102:*.scons_opt=0;38;2;170;170;170:*.gitignore=0;38;2;154;232;69:*.gitconfig=0;38;2;154;232;69:*.gitmodules=0;38;2;154;232;69:*Makefile.am=0;38;2;154;232;69:*.travis.yml=0;38;2;49;136;102:*LICENSE-MIT=0;38;2;102;102;102:*MANIFEST.in=0;38;2;154;232;69:*Makefile.in=0;38;2;170;170;170:*.synctex.gz=0;38;2;170;170;170:*.applescript=0;38;2;49;136;102:*appveyor.yml=0;38;2;49;136;102:*configure.ac=0;38;2;154;232;69:*.fdb_latexmk=0;38;2;170;170;170:*CONTRIBUTORS=0;38;2;0;0;0;48;2;237;147;102:*.clang-format=0;38;2;154;232;69:*CMakeLists.txt=0;38;2;154;232;69:*CMakeCache.txt=0;38;2;170;170;170:*INSTALL.md.txt=0;38;2;0;0;0;48;2;237;147;102:*LICENSE-APACHE=0;38;2;102;102;102:*.gitattributes=0;38;2;154;232;69:*CONTRIBUTORS.md=0;38;2;0;0;0;48;2;237;147;102:*requirements.txt=0;38;2;154;232;69:*CONTRIBUTORS.txt=0;38;2;0;0;0;48;2;237;147;102:*.sconsign.dblite=0;38;2;170;170;170:*package-lock.json=0;38;2;170;170;170'
