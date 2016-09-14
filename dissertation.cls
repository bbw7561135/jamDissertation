% dissertation.cls - University of Maryland doctoral dissertation class
%
% AUTHORS
%    - Pablo A. Straub, Department of Computer Science, University of Maryland
%    - stepped-up to LaTeX2e + some fixes by Jason Lohn
%    - some fixes by Gary Flake (added by JL)
%
% COPYRIGHT
%    (c) Copyright 1991 by Pablo A. Straub.  Permission is granted to copy
%    and use this material for any purpose except direct commercial advantage.
%
% VERSION 1.0
%
% HISTORY (dissertation.cls)
%    Jan 20 16 - Modified chair and advisor to suit my needs for joint advisor. Should probably make it and if statement, but it works for me
%    May 20 08 - Updated to add a file cover.pdf for unofficial
%                versions if desired. (JCV)
%    Aug 05 04 - Updated title page spacing. (DSR)
%    May 12 00 - Updated the title page wording.  Removed the column labels in
%                the table of contents (Section & Page).  Also removed column
%                labels in list of figures and list of tables (Number & Page).  
%
%    Aug 31 95 - dissertation.sty version 2.0 stepped-up to LaTeX2e class
%                and renamed dissertation.cls (version 1.0)
%                Various fixes.
%
% HISTORY (dissertation.sty)
%    Aug 19 91 - First version
%
%    Aug 20 91 - Add redefinition of \@options and remove \input{rep12.sty}.
%              - Change \@ifdefined{@abstractfile}{\makeabstract} to
%                \ifx\@empty \abstractfile \else \makeabstract \fi.
%              - Change \input to \@input for abstract and preface (i.e.,
%                if file is absent give a warning instead of asking for
%                another file.)
%
%    Aug 21 91 - Write captions in single space (captiontable, captionfigure)
%
%    Aug 22 91 - Add optional list entry to captiontable and captionfigure
%              - Add externalfigure command
%              - Add definition of \ds@10pt to enable option 10pt in
%                \documentstyle command
%
%    Aug 30 91 - Add definitions of \footskip and \footnotesep
%              - Enlarge margins to allow for printer or copier shifts
%              - Correct spacing in tiltle page according to the Office of
%                Graduate Studies and Research
%
%    Sep  3 91 - Add saving document style option (to use less paper in drafts
%                and make technical reports) and \ifsaving command
%
%    Sep 13 91 - Change name from dissertation.doc to disseration.sty.
%
%    Sep 26 91 - Put \addcontentsline before \listoffigures and \listoftables
%                to have the right page number when the list is one page or
%                longer
%              - Add \page command
%              - Rename \newbaselinestretch to the simpler \spacing
%
%    Nov  2 91 - Add the masters style option and the \masterof command
%
% DOCUMENTATION
%    Pablo A. Straub, ``The {\tt dissertation} \LaTeX\ Style,''
%    UMIACS-TR-91-134, CS-TR-2768, UMIACS and Department of Computer Science,
%    University of Maryland at College Park, 1991.
%
% INSTALLATION
%    Copy dissertation.cls into LaTeX directory (/usr/imports/lib/tex/latex)
%    or in a directory in the TeX path (environment variable TEXINPUTS).
%
% CONTENTS
%
%    1. Option processing and inclusion of report standard file
%    2. Margins and spacing
%    3. Commands to define parameters for the front matter
%    4. Command \makefrontmatter
%    5. Commands to create different parts of the front matter
%    6. Cross references
%    7. Captioned figures and tables
%    8. Other commands

% ----------------------------------------------------------------------
% 1. Option processing and inclusion of report standard file
% ----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}
              [1995/08/31 v1.0
               Univ of Md LaTeX document class]

\def\diss@temp#1{\@ifundefined{if#1}%
  {\def\@tempa{\csname newif\endcsname}
  \expandafter\@tempa\csname if#1\endcsname}{}}
\diss@temp{saving}{}
\diss@temp{masters}{}
\newcommand{\@repsize}{12pt}     %default font size
\newcommand{\@flakespace}{321pt} %default for 12pt text
\DeclareOption{10pt}{\renewcommand{\@repsize}{10pt}%
                     \renewcommand{\@flakespace}{334pt}}
\DeclareOption{11pt}{\renewcommand{\@repsize}{11pt}%
                     \renewcommand{\@flakespace}{328pt}}
\DeclareOption{12pt}{\renewcommand{\@flakespace}{321pt}}
\DeclareOption{saving}{\savingtrue}
\DeclareOption{masters}{\masterstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[\@repsize]{book}

% ----------------------------------------------------------------------
% 2. Margins and spacing
%
% Rules taken from pages 10-12 of the Style and Policy Manual.
% ----------------------------------------------------------------------
\ifsaving
  \setlength {\topmargin}{0in}          % top margin    1.0 inch
  \setlength {\textheight}{8.5in}       % bottom margin 1.5 inch
  \setlength {\oddsidemargin}{0in}      % left margin   1.0 inch
  \setlength {\textwidth}{6.5in}        % right margin  1.0 inch
\else
%  \setlength {\topmargin}{0.1in}       % top margin    1.10 inch
%  \setlength {\textheight}{8.4in}      % bottom margin 1.50 inch
%  \setlength {\oddsidemargin}{0.5in}   % left margin   1.50 inch
%  \setlength {\textwidth}{6.0in}       % right margin  1 inch
%  \setlength {\footskip}{0.8in}                % two blank lines before page number
  \setlength {\topmargin}{0.0in}        % top margin    1.00 inch
  \setlength {\textheight}{8.9in}       % bottom margin 1.00 inch
  \setlength {\oddsidemargin}{0.55in}   % outside (or left) margin   1.50 inch
  \setlength {\evensidemargin}{0.05in}  % inside (or right) margin   1.0 inch
  \setlength {\textwidth}{5.9in}        % right margin  1 inch
  \setlength {\footskip}{0.6in}         % two blank lines before page number
\fi

\setlength {\footnotesep}{14pt}         % baseline skip for footnotes' 1st line
\setlength {\headheight}{0in}           % no header
\setlength {\headsep}{0in}              % no header separation


% \spacing - redefine \baselinestretch and recompute \baselineskip
%            lateral effect: set typeface to normalize roman

\def\spacing#1{\renewcommand{\baselinestretch}{#1}\large\normalsize}
\def\Bodyspacing#1{\def\bodyspacing{#1}}

\ifsaving
  \Bodyspacing{1.0}
  \spacing{\bodyspacing}                 % single spacing for drafts
\else
  \Bodyspacing{1.7}
  \spacing{\bodyspacing}                 % double spacing for final
\fi


% ----------------------------------------------------------------------
% 3. Commands to define parameters for the front matter
% 
% There are two kinds of commands that define parametters for the  front
% matter:  those  that  provide info (like \author or \abstractfile) and
% those that set flages (like \hascopyright).
% 
% All commands that provide info redefine an internal command named  the
% same but with an initial at sign (e.g., \advisor redefined \@advisor).
% This  idea is standard in LaTeX, so \author, \title, and \date are not
% defined here (the standards are used).
%  
% All commands that set  flags  are  used  to  set  the  status  of  the
% corresponding if command. The parameter must be true or false, or else
% a `Undefined control sequence command' will be issued by TeX.

% ----------------------------------------------------------------------
% The following are the definitions of the commands  that  provide  info
% (standard  LaTeX  commands  like  \author are omitted because they are
% already defined).
% ----------------------------------------------------------------------
\def\advisor#1{\gdef\@advisor{#1}}
\def\chairtitle#1{\gdef\@chairtitle{#1}}
\def\advtitle#1{\gdef\@advtitle{#1}} %jam added this
\def\chairname#1{\gdef\@chairname{#1}} %jam added this
\def\chairdept#1{\gdef\@chairdept{#1}} %jam added this
\def\committee#1{\gdef\@committee{#1}}
\def\department#1{\gdef\@department{#1}}
\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\masterof#1{\gdef\@masterof{#1}}
\def\prefacefile#1{\gdef\@prefacefile{#1}}
\long\def\dedication#1{\long\gdef\@dedication{#1}}
\long\def\acknowledgements#1{\long\gdef\@acknowledgements{#1}}
\long\def\comment#1{\long\gdef\@comment{#1}}

% ----------------------------------------------------------------------
% The following are the initial values for some commands that provide info.
% ----------------------------------------------------------------------
\gdef\@author{{\it Your Full Name}}
\gdef\@title{{\it Your Dissertation Title}}
\gdef\@date{\number\year}
\gdef\@advisor{{\it Academic title and name of advisor}}
\gdef\@chairtitle{Chairman/Advisor}
\gdef\@chairdept{NASA}
\gdef\@advtitle{Advisor} %jam added this
\gdef\@\chairname{Chair Name} %jam added this
\gdef\@committee{{\it Academic title and name of members}}
\gdef\@department{Department of Computer Science}
\def\@abstractfile{abstract}
\gdef\@masterof{Science}

% The following are all switch setting commands along with their initial
% values and corresponding \newif definitions.

\newif\ifhascopyright
\hascopyrighttrue
\def\hascopyright#1{\csname hascopyright#1\endcsname}

\newif\ifhasfigures
\hasfigurestrue
\def\hasfigures#1{\csname hasfigures#1\endcsname}

\newif\ifhastables
\hastablestrue
\def\hastables#1{\csname hastables#1\endcsname}

% ----------------------------------------------------------------------
% 4. Command \makefrontmatter
%        
% The \makefrontmatter command creates the front matter by conditionally
% invoking other commands:
%  
%       \makeabstract, \maketitlepage, \makecopyrightpage, \makepreface,
%       \makededication, \makeacknowledgements, \tableofcontents,
%       \makelistoftables, \makelistoffigures, \makecommentpage.
%
% \makefrontmatter takes care of numbering in lowercase roman, arabic or
% none.
% ----------------------------------------------------------------------
\def\makecover{
  \pagestyle{empty}
  \pdfbookmark[1]{Cover}{cover}
  \includepdf{cover.pdf}
  \cleardoublepage
}
\def\makefrontmatter{
 \pagestyle {empty}
 \ifx\@empty \@abstractfile \else \makeabstract \fi
 \maketitlepage
 \cleardoublepage
%% \phantom{a}\newpage % Running out of time.  Gotta brute-force it.
 \makecopyrightpage
 
 \pagestyle {plain}
 \pagenumbering {roman}
 \setcounter {page}{2}
 \@ifdefined {@prefacefile}{\makepreface}
 \@ifdefined {@dedication}{\makededication}
 \@ifdefined {@acknowledgements}{\makeacknowledgements}
 \spacing{1.1}
 \pdfbookmark[1]{Contents}{toc}%  KG 30 Apr 2006
 \tableofcontents\newpage
 \ifhastables \makelistoftables \fi
 \ifhasfigures \makelistoffigures \fi
 \spacing{\bodyspacing}
% \pagenumbering {arabic}
% \setcounter {page}{0}
% \makecommentpage
% \setcounter {page}{1}
\mainmatter
}

% ----------------------------------------------------------------------
% 5. Commands to create different parts of the front matter
% ----------------------------------------------------------------------
% first, set masters flag
  \ifmasters 
    \gdef\@thesis{Thesis}}
  \else
    \def\@thesis{Dissertation}
  \fi 

% \makeabstract - create the abstract page(s) including title, author, etc.

% Abstract text may be included inside \abstract{ ... } or in an
% external file. Either \abstractfile{...} or \abstract will be used
  \def\@abshere{none}
  \long\def\abstract#1{\long\gdef\@abstract{#1}}
  \gdef\@abstract{none}

\def\makeabstract{
 \newpage
\label{dissertationabstract}                     %  KG 30 Apr 2006
\pdfbookmark[1]{Abstract}{dissertationabstract}  %  KG 30 Apr 2006
% \vspace*{.5in}
 {\spacing{1.1}
 \begin{center}\Large\bf Abstract \end{center}
 \bigskip\par\noindent
 Title of \@thesis: \hspace{0.25in}{\large \begin{tabular}[t]{l} \@title \end{tabular}}
 \bigskip\par\noindent
 \ifmasters
  \Name of degree candidate: \@author
  \bigskip\par\noindent
  Degree and year: Master of \@masterof, \@date
 \else
  %\begin{center}
 \hspace{1.9in}\@author, Doctor of Philosophy, \@date
  % \end{center}
 \fi
 \bigskip\par\noindent
 \@thesis\ directed by:
 \begin{tabular}[t]{l}\@advisor \\ \@department \\ \\ \@chairname \\ \@chairdept \end{tabular}
 \bigskip\par\mbox{}\hugeskip\par}
 %%%---insert proper abstract text---
   \ifx\@abstract \@abshere
     \@input{\@abstractfile}
   \else
     \@abstract
   \fi
 \newpage}

% \maketitlepage - create the title page according to a complex format
\def\maketitlepage{
 \newpage
\label{dissertationtitlepage}                     %  KG 30 Apr 2006
\pdfbookmark[1]{Title Page}{dissertationtitlepage}%  KG 30 Apr 2006
 \vspace*{.4in}
 \begin{center}
 % \spacing{1.3}
 \spacing{1.0} % DSR, 8/5/04
 {\Large\bf \begin{tabular}[t]{c}\@title\end{tabular}}
 \\ \hugeskip
 {\large by \\ \Large \bigskip \@author}
 \end{center}
 \bigskip
 \bigskip
 %{\spacing{1.1} % rem. DSR, 8/5/04
 {\spacing{1.0}
 \begin{center}
 {\large \ifmasters Thesis \else Dissertation \fi
          submitted to the Faculty of the Graduate School of the \\
 University of Maryland at College Park in partial fulfillment \\
 of the requirements for the degree of \\
 \ifmasters Master of \@masterof \else {Doctor of Philosophy} \fi\\
 \@date}
 \end{center}
% \hugeskip\par\mbox{}\hugeskip\par\hspace*{15pt}
%JAM: changed from 60pt to -27 to  get it to go left
%JAM: probably a better way to do this
 \vfill
 {\large Advisory Committee:
 \medskip\par\hspace*{-28pt}
 \begin{tabular}[t]{l}\@advisor, \@advtitle \\ \@chairname, \@chairtitle \\ \@committee \end{tabular}}}
 \newpage}

% \makecopyrightpage - create a copyright page or an empty page
\def\makecopyrightpage{
 \newpage
\label{dissertationcopyright}                     %  KG 30 Apr 2006
\pdfbookmark[1]{Copyright}{dissertationcopyright}%  KG 30 Apr 2006
 \mbox{}\par\vfill
 \ifhascopyright
  {\large
  \begin{center}
 %JAM: Revert to the other copy right
% I prefer this
  %\boldmath $\copyright$ \@author\ \@date \\
% instead of the grad school suggested this
  \boldmath $\copyright$ Copyright by \\
  \@author \\
  \@date
  \end{center}}
  \vfill
 \fi
 \newpage}

% \makepreface - create a preface from file \@prefacefile
\def\makepreface{
 \newpage
\label{dissertationpreface}                     %  KG 30 Apr 2006
\pdfbookmark[1]{Preface}{dissertationpreface}%  KG 30 Apr 2006
 \chapter*{Preface}
 \@input{\@prefacefile}
 \newpage}

% \makededication - create a dedication page
\def\makededication{
 \newpage
 \label{dissertationdedication}                     %  KG 30 Apr 2006
 \pdfbookmark[1]{Dedication}{dissertationdedication}%  KG 30 Apr 2006
 \vspace*{2in}
 \begin{center}\LARGE\bf Dedication \end{center}
 \hugeskip\par\noindent
 \begin{quote} \@dedication \end{quote}
 \newpage}

% \makeacknowledgements - create an acknowledgements page
\def\makeacknowledgements{
 \newpage
 \label{dissertationacknowledgements}                     %  KG 30 Apr 2006
 \pdfbookmark[1]{Acknowledgements}{dissertationacknowledgements}%  KG 30 Apr 2006
 \vspace*{2in}
 \begin{center}\LARGE\bf Acknowledgements \end{center}
 \hugeskip\par\noindent
 \begin{quote} \@acknowledgements \end{quote}
 \newpage}

% \makelistoftables - create the list of tables
\def\makelistoftables{
 \newpage
 \phantomsection
 \addcontentsline {toc}{chapter}{List of Tables}
 \listoftables
 \newpage}

% \makelistoffigures  - create the list of figures
\def\makelistoffigures{
 \newpage
 \phantomsection
 \addcontentsline {toc}{chapter}{List of Figures}
 \listoffigures
 \newpage}

% \makecommentpage - create a (possibly empty) comment page
\def\makecommentpage{
 \label{dissertationcommentpage}                     %  KG 30 Apr 2006
 \pdfbookmark[1]{Comment Page}{dissertationcommentpage}%  KG 30 Apr 2006
 {\spacing{1}
 \begin{center}\@title \\[1ex]  \@author \\[1ex] \today \end{center}
 \par\vfill
 \@ifdefined{@comment}{\@comment}
 \par\vfill}
 \begin{center} \large\bf This comment page is not part of the dissertation.
 \\[3ex]
 \footnotesize Typeset by \LaTeX\ using the {\tt dissertation} class by
               Pablo A. Straub, University of Maryland.
 \end{center}
 \newpage}

% ----------------------------------------------------------------------
% 6. Cross references
%
% The following commands facilitate cross references, by using the \ref
% or \pageref command in context.
% ----------------------------------------------------------------------
\newcommand{\Chapter}[1]{Chapter~\ref{#1}}
\newcommand{\Section}[1]{Section~\ref{#1}}
\newcommand{\Figure}[1]{Figure~\ref{#1}}
\newcommand{\Table}[1]{Table~\ref{#1}}
\newcommand{\page}[1]{page~\pageref{#1}}
% ----------------------------------------------------------------------
% 8. Other commands
% ----------------------------------------------------------------------

% \hugeskip - skip twice as much as the TeX command \bigskip
\def\hugeskip{\vskip 24pt plus 8pt minus 8pt}

% \@ifdefined - expand #2 if command #1 is not defined
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}

\endinput

%% End of file `dissertation.cls'.