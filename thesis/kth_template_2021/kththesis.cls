%% forked from https://gits-15.sys.kth.se/giampi/kthlatex kthlatex-0.2rc4 on 2020-02-13
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kththesis}[2018/04/26 KTH Thesis formatting]

\newif\ifinswedish
\DeclareOption{english}{}
\DeclareOption{swedish}{\inswedishtrue}

\newif\ifgfivepaper
\DeclareOption{a4paper}{}
\DeclareOption{g5paper}{\gfivepapertrue}

\newif\ifbachelor
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{}

%% Send any unknown option to the report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\ifgfivepaper
  \LoadClass[10pt]{report}
\else
  \LoadClass[12pt]{report}
\fi

% to do string comparison
\usepackage{xstring}

% to support units and decimal aligned columns in tables
\usepackage{siunitx}

% Make it possible to conditionally depend on the TeX-engine used
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxeorlua
\ifxetex\xeorluatrue\fi
\ifluatex\xeorluatrue\fi

%% Load other packages

\ifxeorlua
  \RequirePackage{polyglossia}
  \ifinswedish
    \setmainlanguage{swedish}
    \setotherlanguage{english}
  \else
    \setmainlanguage{english}
    \setotherlanguage{swedish}
  \fi
\else
  \RequirePackage[utf8]{inputenc}
  \ifinswedish
     \RequirePackage[main=swedish,main=USenglish,UKenglish,french,spanish,norsk,ngerman,danish,dutch,estonian]{babel}
  \else
    \RequirePackage[swedish,main=USenglish,UKenglish,french,spanish,norsk,ngerman,danish,dutch,estonian]{babel}
  \fi
\fi

\ifgfivepaper
\RequirePackage[paperwidth=169mm,paperheight=239mm,twoside,
  top=30mm,bottom=30mm,inner=36mm,outer=18mm,
  headsep=10mm,headheight=5mm]{geometry} % Set paper and contents dimensions
\else
\RequirePackage[a4paper,twoside,
  top=37mm,bottom=50mm,inner=45mm,outer=35mm,
  headsep=15mm,headheight=6mm,footskip=25mm]{geometry} % Set paper and contents dimensions
\fi
\RequirePackage{fancyhdr} % Take control of headers and footers
%\RequirePackage{emptypage} % Supress page numbers on otherwise empty pages

\RequirePackage{pdfpages} % Used to include the preformatted KTH cover pages

\RequirePackage{titlesec} % Redefine the appearance of headers
% === Patch to circumvent a bug in the titlesec package version 2.10.1
\@ifpackagelater{titlesec}{2016/03/21}{%
 % Package titlesec is on version 2.10.2 or higher, nothing to do %
}{%
 % Check if package titlesec is on version 2.10.1 %
 \@ifpackagelater{titlesec}{2016/03/15}{%
  % Package titlesec on version 2.10.1, patch accordingly %
  \RequirePackage{etoolbox}%
  \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
  \patchcmd{\ttlh@hang}{\noindent}{}{}{}%
 }{%
  % Package titlsecon is on version 2.10.0 or lower, nothing to do %
 }%
}
% === End ot titlesec patch

\ifxeorlua
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures={TeX}} % This enables TeX style ligatures such as ---, '', ``, and so on
  \setmainfont{TeX Gyre Termes}  %% Times like font
  \setsansfont{TeX Gyre Heros}   %% Helvetica like font
  \setmonofont{TeX Gyre Cursor}  %% Courier like font
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{tgtermes}
  \RequirePackage{tgheros}
  \RequirePackage{tgcursor}
\fi

% Set up the header and footer
\fancyhead{}
\fancyhead[RO]{\sffamily\small\leftmark\thinspace|\thinspace\thepage}
\fancyhead[LE]{\sffamily\small\thepage\thinspace|\thinspace\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Add 5% extra linespacing
\linespread{1.05}

% Set the proper format for the headers
\titleformat{\chapter}[display]
  {\normalfont\sffamily\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries}
  {\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\sffamily\large\bfseries}
  {\thesubsection}{1em}{}

\renewenvironment{abstract}{\section*{\abstractname}}

% Define commands for setting the user definable parts of the title page
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\examiner}[1]{\def\@examiner{#1}}
\let\@secondauthor\@empty
\newcommand{\secondauthor}[1]{\def\@secondauthor{#1}}
\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\let\@alttitle\@empty
\newcommand{\alttitle}[1]{\def\@alttitle{#1}}
\let\@altsubtitle\@empty
\newcommand{\altsubtitle}[1]{\def\@altsubtitle{#1}}
\let\@hostcompany\@empty
\newcommand{\hostcompany}[1]{\def\@hostcompany{#1}}
\let\@hostorganization\@empty
\newcommand{\hostorganization}[1]{\def\@hostorganization{#1}}
\let\@email\@empty
\newcommand{\email}[1]{\def\@email{#1}}
\let\@secondEmail\@empty
\newcommand{\secondEmail}[1]{\def\@secondEmail{#1}}

\let\@school\@empty
\newcommand{\school}[1]{\def\@school{#1}}
\let\@programme\@empty
\newcommand{\programme}[1]{\def\@programme{#1}}
%

%\newcommand{\programcode}[1]{\def\@programcode{#1}}
%\newcommand{\decide}[3]{%
%  \IfStrEq{\@programcode}{#1}{#2}{#3}%
%}

% get all of the information about the school codes and program codes
\input{schools_and_programs.ins}


\newcommand{\MONTH}{%
  \ifinswedish
  \ifcase\the\month
  \or januari% 1
  \or februari% 2
  \or mars% 3
  \or april% 4
  \or maj% 5
  \or juni% 6
  \or juli% 7
  \or augusti% 8
  \or september% 9
  \or oktober% 10
  \or november% 11
  \or december% 12
  \fi
  \else
  \ifcase\the\month
  \or January% 1
  \or February% 2
  \or March% 3
  \or April% 4
  \or May% 5
  \or June% 6
  \or July% 7
  \or August% 8
  \or September% 9
  \or October% 10
  \or November% 11
  \or December% 12
  \fi
\fi
}

% covers are separately made and applied
%\let\@kthcover\@empty
%\newcommand{\kthcover}[1]{\def\@kthcover{#1}}

% Command to print out the standardized title page
\renewcommand{\titlepage}{
\ifgfivepaper
  \newgeometry{top=65mm,bottom=30mm,left=62mm,right=18mm}
\else
  \newgeometry{top=65mm,bottom=30mm,left=50mm,right=35mm}
\fi

\thispagestyle{empty}

\ifinswedish\selectlanguage{swedish}\fi

\begin{huge}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@title \par
  \end{flushleft}
\end{huge}

\ifx\@subtitle\@empty\relax
\else
\begin{Large}
  \vspace{1ex}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@subtitle \par
  \end{flushleft}
\end{Large}
\fi

\vspace{10mm}
\begin{large}
  \begin{flushleft}
    \sffamily
    \expandafter\MakeUppercase\expandafter\@author \par
    \ifx\@secondauthor\@empty\relax
    \else\vspace{1ex}\expandafter\MakeUppercase\expandafter\@secondauthor \par
    \fi
  \end{flushleft}
\end{large}

\vfill

\begin{flushleft}
  \sffamily
  \ifinswedish
    \@programme\\
    \ifx\@date\@empty\relax\else Datum: \@date\\\fi
    Handledare: \@supervisor\\
    Examinator: \@examiner\\
    School: \@school\\
    \ifx\@hostcompany\@empty\relax\else Uppdragsgivare: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Uppdragsgivare: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Engelsk titel: %
    \begin{otherlanguage}{USenglish}\sffamily\@alttitle\end{otherlanguage} \fi
    \ifx\@altsubtitle\@empty\relax
    \else
    English subtitle \begin{otherlanguage}{USenglish}\sffamily\@altsubtitle\end{otherlanguage} \\
    \fi
  \else
    \@programme\\
    \ifx\@date\@empty\relax\else Date: \@date\\\fi
    Supervisor: \@supervisor\\
    Examiner: \@examiner\\
    \@school\\
    \ifx\@hostcompany\@empty\relax\else Host company: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Swedish title: %
        \begin{otherlanguage}{swedish}\sffamily\@alttitle\end{otherlanguage}  \\ \fi
    \ifx\@altsubtitle\@empty\relax \else Swedish subtitle: %
        \begin{otherlanguage}{swedish}\sffamily\@altsubtitle\end{otherlanguage} \\ \fi
  \fi
\end{flushleft}
\restoregeometry
\clearpage
}

% Command to print out the standardized document information page
\newcommand{\bookinfopage}{
\ifgfivepaper
  \newgeometry{top=200mm,bottom=30mm,left=62mm,right=18mm}
\else
  \newgeometry{top=200mm,bottom=30mm,left=50mm,right=35mm}
\fi
\thispagestyle{empty}
\begin{flushleft}
  \sffamily \@title 
  \ifx\@alttitle\@empty\relax
  \else
    \quad / \quad \@alttitle
  \fi

  \vspace{15 mm}
  \copyright\enspace\the\year\quad\@author 
  \ifx\@secondauthor\@empty\relax
  \else
    \ifinswedish
      \enspace och\enspace\@secondauthor \\
    \else
      \enspace and\enspace\@secondauthor \\
    \fi
  \fi
\end{flushleft}
\restoregeometry
\clearpage
}

\newcommand{\acknowlegmentssignature}{
  \begin{flushleft}
    Stockholm, \MONTH\enspace\the\year\\
    \@author
    \ifx\@secondauthor\@empty\relax
    \else
       \ifinswedish
       \enspace och\enspace\@secondauthor \\
       \else
       \enspace and\enspace\@secondauthor \\
       \fi
    \fi
  \end{flushleft}
\cleardoublepage
}

\newcommand{\frontmatter}{
  \pagenumbering{roman}
  \setcounter{page}{1}
}

\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}
}

% {
%    "Author1":{
%	"Last name": "Maguire Jr.",
%	"First name": "Gerald Q.",
%	"Local User Id": "u1d13i2c",
%	"Research group": "CCS",
%	"E-mail": "maguire@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS"
%			}
%    },
%    "Author2":{
%	"Last name": "Noz",
%	"First name": "Marilyn E.",
%	"E-mail": "men@bogus.org",
%	"Other organisation": "NYU"
%    },
%
%    "Cooperation":{
%	"Partner_name": "ABBBBA"
%    },
%    "Title":{
%	"Main title": "This is a long title in English",
%	"Subtitle": "This is an even longer subtitle in English",
%	"Language": "eng"	
%    },
%    "Alternative title":{
%	"Main title": "Detta är en lång titel på svenska",
%	"Subtitle": "Detta är en ännu längre undertexter på svenska",
%	"Language": "swe"
%    },
%    "Degree":{
%	"Level": "Independent thesis Basic level (degree of Bachelor)",
%	"University credits": "15 HE credits",
%	"Educational program": "Bachelor of Science in Engineering - Computer Engineering",
%	"Subject_course": "Communications Systems"
%    },
%    "Content category":{
%    },
%    "Other information":{
%	"Year": "2019",
%	"Number of pages": "xiii,72"
%    },
%    "Series":{
%	"Title of series": "TRITA-ICT-EX",
%	"No. in series": "2019:00"
%    },
%    "Other series":{
%	"Title of series": "",
%	"ISSN": "",
%	"EISSN": "",
%	"No. in series": ""
%    },
%    "Identifiers":{
%	"ISRN": "",
%	"DOI": "",
%	"DOI_Free_full_text": "",
%	"URL": "",
%	"URL label": "",
%	"URL_Free_full_text": ""
%    },
%    "National subject category":{
%	"L1": "Engineering and Technology",
%	"L2": "Electrical Engineering, Electronic Engineering, Information Engineering",
%	"L3": "Communication Systems"
%    },
%    "Part of project":{
%    },
%    "Part of other project":{
%	"Project_name": ""
%    },
%    "Keywords1":{
%	"Keywords": "Fiddle,Fee,Foo,Fum",
%	"Language": "eng"
%    },
%    "Keywords2":{
%	"Keywords": "Faddle,Fåå,Fää,Fööm",
%	"Language": "swe"
%    },
%    "Abstract1":{
%	"Abstract":	"<p>This is a abstract for an non existant thesis about <sup>18</sup>F<sup>-</sup></p>",
%	"Language": "eng"
%    },
%    "Abstract2":{
%	"Abstract":	"<p>Detta är ett abstrakt för en icke-existerande avhandling om <sup>18</sup>F<sup>-</sup></p>",
%	"Language": "swe"
%    },
%    "Supervisor1":{
%	"Last name": "Västberg",
%	"First name": "Anders",
%	"Academic title": "universitetslektor",
%	"Local User Id": "u1ft3a12",
%	"Research group": "RS",
%	"ORCiD": "0000-0002-4226-9652",
%	"E-mail": "vastberg@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS",
%			 "L3": "Radio Systems Laboratory (RS Lab)"}
%    },
%    "Supervisor2":{
%	"Last name": "Normal",
%	"First name": "A. B.",
%	"E-mail": "ABNormal@example.org",
%	"Other organisation": "Famous Anvils"
%    },
%    "Examiner1":{
%	"Last name": "Maguire Jr.",
%	"First name": "Gerald Q.",
%	"Academic title": "professor",
%	"Local User Id": "u1d13i2c",
%	"ORCiD": "0000-0002-6066-746X",
%	"Research group": "CCS",
%	"E-mail": "maguire@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS",
%			 "L3": "Radio Systems Laboratory (RS Lab)"}
%    },
%    "Presentation":{
%	"Date": "2019-07-25 4:31",
%	"Language": "eng",
%	"Room": "Seminar room Grimeton at COM",
%	"Address": "Kistagången 16, East, Floor 4, Elevator B",
%	"City": "Kista"
%    },
%    "Note" :{
%	"Note": "<p><span style='color: red;'>A completely bogus entry for testing with Puppeteer using diva5.js</span></p>"
%    },
%    "File" :{
%	"Filename": "/home/maguire/Diva/z2.pdf",
%	"Accept full text": "true"
%    }
%
%}

\newcommand{\divainfo}[2]{
\thispagestyle{empty}
    \sffamily\tiny
    \{\\
        "Author1": \{ "name": "\@author"\},\\
    \ifx\@secondauthor\@empty\relax
    \else
        "Author2": \{ "name": "\@secondauthor"\},\\
    \fi
       "Degree": \{"Educational program": "\@programme"\},\\
       "Title": \{\\
            "Main title": "\@title",\\
            \ifx\@subtitle\@empty\relax
            \else
            "Subtitle": "\@subtitle",\\
            \fi
        \ifinswedish
            "Language": "swe"
        \else
            "Language": "eng"
        \fi
       \},\\
    "Alternative title": \{\\
	"Main title": "\@alttitle",\\
        \ifx\@altsubtitle\@empty\relax
            \else
            "Subtitle": "\@altsubtitle",\\
        \fi
        \ifinswedish
            "Language": "eng"\\
        \else
            "Language": "swe"\\
        \fi
    \},\\
    "Supervisor1": \{ "name": "\@supervisor" \},\\
    "Examiner": \{\\
      "name":  "\@examiner",\\
      "organisation": \{"L1": "\@school" \}\\
    \},\\
    \ifx\@hostcompany\@empty\relax\else
    "Cooperation": \{ "Partner\_name": "\@hostcompany"\},\\
    \fi
    % \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization\\\fi
    "Other information": \{\\
      "Year": "\the\year",
      "Number of pages": \char`\"\pageref{#1},\pageref{#2}\char`\"
    \}\\
   \}
\clearpage
}


\endinput
