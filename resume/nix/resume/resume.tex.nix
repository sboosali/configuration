##################################################
{ tex ? import ./tex.nix {}
, cv  ? import ./cv.nix  { inherit tex; }
}:

##################################################
{ class
, fontsize

, contact
, education
, career
}:

##################################################
let

##################################################

in
##################################################
''
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Every LaTeX document has a document class. For this document, I will use a custom resume class.

${tex.documentclass { inherit fontsize class; }}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Next, I’ll provide some semantic information. Each of these commands is defined in the résumé class. 

\name{${contact.name.first}}{${contact.name.last}}
\address{${contact.address}}
\mobile{${contact.mobile}}
\email{${contact.email}}
\homepage{${contact.homepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %% This begins the document. The command makecvheader is from resume.cls and will setup the basic template.

\begin{document}

\makecvheader[C]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\cvsection{Education}

  \begin{cventries}

  %% Each =cvsection= is composed of multiple =cventries=.

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

${cv.mkEducation { indentation = 6; } education}

  %% Visually:
  %% 
  %% | left         | right        |
  %% |--------------+--------------|
  %% | argument 1   | /argument 2/ |
  %% | /argument 3/ | /argument 4/ |

  %% Semantically:
  %% 
  %% | left                  | right                   |
  %% |-----------------------+-------------------------|
  %% | Company or University | /Location/              |
  %% | /Position or degree/  | /Start date - end date/ |

  \end{cventries}

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  \cvsection{Work Experience}

  \begin{cventries}

${cv.mkCareer { indentation = 6; } career}

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %% \cventry
  %%   {Amazon.com, Inc.}
  %%   {Seattle, WA, USA}
  %%   {SDE Intern}
  %%   {Summer 2017}
  %%   {
  %%     \begin{cvitems}
  %%     \item { Worked on Mobile Identity team which manages the login screens for
  %%             Amazon apps }
  %%     \item { Project made it easier for teams to register new devices through
  %%             Identity Services }
  %%     \item { Used Agile development principles in design and development of
  %%             project }
  %%     \end{cvitems}
  %%   }
  %% 
  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% 
  %% \cventry
  %%   {Lexmark Enterprise Software}
  %%   {Lenexa, KS, USA}
  %%   {Software Engineer Intern}
  %%   {Summer 2015, Summer 2016}
  %%   {
  %%     \begin{cvitems}
  %%     \item { Worked on the Client Architecture team which builds the JavaScript
  %%         web framework which other teams use to build enterprise solutions }
  %%     \item { Participated in high level design decision conversations }
  %%     \item { Project moved the web framework away from in-house solutions to
  %%         better maintained open source projects while preserving legacy
  %%         compatibility }
  %%     \item { Asked to return after impressive first year }
  %%     \end{cvitems}
  %%   }
  %% 
  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% 
  %% \cventry
  %%   {Together+Clinic}
  %%   {Lincoln, NE, USA}
  %%   {Design Studio Intern}
  %%   {Spring 2015}
  %%   {
  %%     \begin{cvitems}
  %%     \item { Startup building web app to let doctors track patients recovering
  %%         from surgery without frequent checkup visits }
  %%     \item { The web interface is used by both patients to record progress and
  %%         doctors to track progress }
  %%     \item { Team used Scrum development principles for quick response and user
  %%         focused design }
  %%     \end{cvitems}
  %%   }
  %% 
  %% \end{cventries}
  %% 
  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% 
  %% \cvsection{Honors \& Awards}
  %% 
  %% \begin{cvhonors}
  %% 
  %%   \cvhonor
  %%   {3rd Place}
  %%   {JayHacks Hackathon}
  %%   {Lawrence, KS, USA}
  %%   {2017}
  %% 
  %%   \cvhonor
  %%   {Grand Prize}
  %%   {Google Code-in}
  %%   {Mountain View, CA, USA}
  %%   {2013}
  %% 
  %% \end{cvhonors}

 %% The =makecvfooter= command gives a nice footer that will be put at the bottom
 %% of each page. This can give us the document title and page numbering. In
 %% addition, the LastPage command will tell us how many pages there are in case
 %% we misplace a page while printing.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makecvfooter
    {SBOOSALI}
    {\thepage}
    {\pageref{LastPage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\end{document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
''