\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{afla}[2015/05/05 AFLA 22+ Proceedings style]
% Michael Yoshitaka Erlewine, May 2015
% mitcho@mitcho.com
% LAST UPDATED: 2021/11/18

\PassOptionsToClass{12pt}{article}
\LoadClass{article}

% paper size and margins
\DeclareOption{letterpaper}{
\PassOptionsToPackage{letterpaper, margin=1in, headsep=8.7mm}{geometry}
% letterpaper = US letter paper
% headsep = 1in - 12.5mm - height of header (12pt = 4.2mm) = 8.7mm
}

\DeclareOption{b5j}{
\PassOptionsToPackage{b5j, margin=20mm, headsep=3.3mm}{geometry}
% b5j = JIS B5 paper
% headsep = 20mm - 12.5mm - height of header (12pt = 4.2mm) = 3.3mm
}

\ExecuteOptions{letterpaper} % default
\ProcessOptions\relax

\RequirePackage{geometry}

% formatting
\RequirePackage{fancyhdr}
\RequirePackage{calc}
\RequirePackage{multicol}

% bib
\RequirePackage{natbib}
\setcitestyle{aysep={}}

% fonts and symbols
\RequirePackage{times}
\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath,amssymb}
\RequirePackage[font=footnotesize]{caption} % 10pt font size in captions

% paper title block formatting
\RequirePackage{titling}
\setlength{\droptitle}{-6pt}
% To be honest there's no rhyme or reason to this particular droptitle;
% I'm just trying to get it to match the output of the Word template.
\pretitle{\parskip=0pt\par\centering\fontsize{14pt}{18pt}\selectfont}
% We do not handle uppercasing of the title automatically, due to
% a complication with the \thanks footnote command
\posttitle{\par\vspace*{14pt}}
\preauthor{\parskip=0pt\par\centering\normalsize\begin{tabular}[t]{c}}
\postauthor{\end{tabular}\par}
\predate{\date{}}
\postdate{\vspace*{-4pt}}
% \maketitle automatically adds 1.5em = 18pt; we want 14pt, so -4pt.
\setlength{\thanksmarkwidth}{5pt}
\setlength{\thanksmargin}{-\thanksmarkwidth}

% Magic for handling multiple \authors:
\makeatletter
\def\@author{}
\def\author#1{%
	\ifx\@author\empty
		\gdef\@author{#1}
	\else
		\expandafter\gdef\expandafter\@author\expandafter{\@author\end{tabular}\begin{tabular}[t]{l}#1}
		\preauthor{\parskip=0pt\par\centering\normalsize\begin{tabular}[t]{l}}
	\fi
}
\makeatother

% abstract environment
\renewenvironment{abstract}
{\parskip=0pt\par\centering\begin{minipage}{\linewidth - 1in}\fontsize{10}{12}\selectfont}
{\end{minipage}\par\ignorespacesafterend\normalsize}

% section title formatting
\RequirePackage{titlesec}
\titlelabel{\begin{minipage}{0.5in}\thetitle.\end{minipage}}
\titleformat*{\section}{\fontsize{12pt}{14pt}\bf}
\titleformat*{\subsection}{\fontsize{12pt}{14pt}}
\titleformat*{\subsubsection}{\fontsize{12pt}{14pt}}
\titlespacing*{\section}{0pt}{14pt}{14pt}
\titlespacing*{\subsection}{0pt}{14pt}{14pt}
\titlespacing*{\subsubsection}{0pt}{14pt}{14pt}

% The AFLA guidelines for example formatting is kind of tricky to accomplish, but
% it can be done using ExPex. Here's the setup:
\RequirePackage{expex}
\lingset{numoffset = 0pt, aboveexskip = 14pt, belowexskip = 2pt, sampleexno=(10), textoffset=1.3em, everygla=\rm, belowglpreambleskip=-2pt, aboveglbskip=1pt, aboveglftskip=-2pt,glhangindent=0em, appendtopexarg={preambleoffset=1.3em, labeloffset=0in, textoffset=0.65em, interpartskip=0pt, belowpreambleskip=0pt}}

% footnote formatting
\RequirePackage[flushmargin,multiple,bottom]{footmisc}
\renewcommand{\footnotemargin}{0.5em}
% Modify paragraph indentation in footnotes. \fn{} is kept for backwards compatibility?
\newcommand{\fn}[1]{\footnote{\setlength{\parindent}{0.5in} #1}}
\makeatletter
\let\@oldfntext\@makefntext
\renewcommand{\@makefntext}[1]{\@oldfntext{%
	% Format examples in footnotes
	\keepexcntlocal
	\excnt=1
	\lingset{aboveexskip = \baselineskip, belowexskip = 1pt, exnotype = roman}
	% Other footnote formatting
	\setlength{\parindent}{0.5in}
	#1
}}
\makeatother
% Command for footnote with a symbol instead of a number
\long\def\symbolfootnote[#1]#2{\begingroup%
\def\thefootnote{\fnsymbol{footnote}}\footnote[#1]{#2}\endgroup}

% items
\RequirePackage{enumitem}
\setlist[enumerate]{leftmargin=0.5in,nosep}
\setlist[itemize]{leftmargin=0.5in,nosep}

% trees
\RequirePackage[nocenter]{qtree}

\newcounter{aflanumber}
\setcounter{aflanumber}{0}

\AtBeginDocument{
	\raggedbottom
	\fontsize{12pt}{14pt}\selectfont
	\parskip = 0in
	\parindent = 0.5in

	\pagestyle{fancy}
	\fancyhead{}
	\fancyfoot{}
	\fancyhead[C]{\fontsize{12pt}{14pt}\selectfont \textit{The Proceedings of AFLA \arabic{aflanumber}}}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}

	\bibsep=0pt
	\bibhang=0.5in
	\bibliographystyle{linquiry2}

	% now make sure \maketitle doesn't mess up the pagestyle:
	\let\OriginalMaketitle\maketitle
	\renewcommand{\maketitle}{\OriginalMaketitle\thispagestyle{fancy}}
}
