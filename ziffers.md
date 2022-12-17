---
# This template is licensed under a Creative Commons 0 1.0 Universal License (CC0 1.0). Public Domain Dedication.

title: 'Ziffers - Numbered Notation for Algorithmic Composition'
author:
  - name: Miika Alonen
    affiliation: Department of Computer Science. Aalto University, Finland
    email: miika.alonen@aalto.fi
  - name: Raphaël Maurice Forment
    affiliation: ECLLA. Université Jean Monnet, France
    email: raphael.forment@univ-st-etienne.fr
abstract: |
    Ziffers is an algorithmic number based musical notation system. It offers concise syntax to support composition and improvisation with complex melodies and rhythms. Ziffers is the result of experiments in unifying several types of musical notation centred around the use of symbols and numbers. It is inspired by the older numbered musical notations (*Ziffersystem*, *Jianpu*), contemporary music theory (pitch-class sets, post-tonal music analysis, serialism) and shorthand notations used in live-coding. Ziffers aims for a balance between fixed media music notation and generative notations for live coding performance. In this article, we propose an implementation agnostic numbered notation for algorithmic composition and live coding. As a proof of concept, this article will also present a live-coding framework for Ziffers notation and an export plugin for a general purpose scorewriter. In doing so, we hope to highlight the versatility of our approach in using unified syntax for different contexts of execution and interpretation.
fontsize: 11pt
geometry: margin=2cm
fontfamily: libertine
fontfamily: inconsolata
mainfont: Linux Libertine O
monofont: Inconsolata
bibliography: references.bib
header-includes:
    - \usepackage{float}
...
# INTRODUCTION: ZIFFERS, QUICKLY EDITABLE NUMBER BASED NOTATION

**Ziffers** — named and inspired by the older *Ziffersystem* [@warkentin2022story] — proposes a system focused on the conciseness and expressiveness of musical notation. Ziffers is designed to enable generation and transformation of musical patterns [@mccormack1996grammar;@mclean2020algorithmic] in minimal amounts of time and typing. To do so, Ziffers uses a text-based syntax for representing various short-hand symbolic notations used in music theory. It also includes various syntactic-sugar constructs from different programming languages, like the ternary operator and the lisp-like syntax for lists. The need for a concise and succinct notation in the context of live coding performance is a well-known constraint [@roberts2018tensions]. It gave rise, in the past decades, to many practices and techniques aiming to reduce frictions in the conversational feedback loop between the musician and its programming interface. Domain specific languages (DSLs) and the use of terse mini notations have become an important design pattern in the conception of live coding interfaces [@hoogland2019mercury]. They can also be noted to be a key concept in the larger realm of exploratory or conversational open-ended programming where reactivity and fast decision-making is of prime importance to achieve a creative state of flow [@nash2015cognitive;@kery2017exploring]. Consequently, the Ziffers system has been influenced by *TidalCycles* [@mclean2010tidal] and *Ixi Lang* [@magnusson2011ixi]. In their lineage, Ziffers intends to propose a powerful mini-notation system allowing the on-the-fly alteration of musical patterns.

Ziffers is designed as a terse and platform independent syntax capable of embedding algorithmic and generative processes at the notational level. Basic tokens denoting pitch, rhythm or expression marks form to the base notation. They have subsequently been enriched by operators and generative constructs denoting algorithmic transformations built upon that first layer. Presented framework for using Ziffers in live-coding is built on *Sonic Pi* [@aaron2016sonic], a live coding platform designed for education and music performance. Ziffers initially took form as an attempt to speed up the process of writing melodic lines by taking advantage of the large number of predefined methods and compositional helpers offered by *Sonic Pi's* rich internal library. The dissociation between pitch and rhythm imposed by *Sonic Pi* data structures and imperative-oriented programming model lead to the development of the first prototype of Ziffers [@ziffers2018]. After a few years of research and prototyping, Ziffers 2.0 was released in 2022 [@ziffers2022]. It includes a new parser that extends Ziffers capabilities with new operators and nested structures for greater support in stochastic and aleatoric composition.

# Method: Designing by drawing from music notation history

The Ziffers music notation is confronting historical numeric pitch-based music notation practices with the kairotic notations [@cocker2013live] typically found in live coding and algorithmic music performance systems [@blackwell2022live]. Therefore, the system has been designed iteratively, in conversation with the diverse and complex historical legacy of said practices. Documents pertaining to the systems of numeric pitch notation in common practice can be traced back as early as the European baroque up to the contemporan era through examples as varied as the American Nashville system, the Chinese Jianpu simplified notation [@kaminski2022jianpu;@mnma2022] or the theoretical pitch-class set numbering of musical structures and chords used in post-tonal music theory [@forte1973structure].

Numerical systems for score, harmonic or melodic writing –– less commonly encountered than their staff-based counterparts –– have historically served as compositional tools for polyphonic contrapuntal notation [@davantes1560], early theoretical endeavours in algorithmic composition [@kircher1650] or in pedagogy and teaching [@rousseau1781projet]. Finding a new breath during the late nineteenth-century through the Galin-Paris-Chevré notation [@dauphin2012devenir], the practice spread to Asia where it is widely used, known and practiced, sometimes concurrently with standard staff notation. Some specialized applications of numbered notation can also be found in the toolset of ethnomusicologists and ethnomathematicians that often take advantage of the versatility of symbolic cipher notation to devise notation systems capable of formalizing musical systems or previously non-written musical practices [@Schaffrath1997;@chemillier2002ethnomusicology].

We perceive –– as a thought experiment –– the use of mininotations [@magnusson2018performing] as modern live coding analogues to previously mentioned numerical music notation systems. In that regard, with their conciseness and economy of expression, we observe that older non-computer based numerical notations systems are adequate fits for the domain but have never been fully transposed and applied to the realm of live coding performance. Strikingly, we see them being used by musicians and music theorists alike as pragmatic and practical tools for draft notation and information sharing. In our opinion, the versatility of pitch-based number notations as well as their adequacy to the traditional way of inputting complex data structures (as lists, arrays or ordered data) in the most music programming languages [@roads1996computer;@dannenberg2018languages] make this type of notation a fruitful exploration domain for live coding and computer-based music notation alike. Generative numeric notation can also mitigate the separation between static and dynamic music notation languages as defined by Dannenberg's typology of the domain. Examples such as Adagio [@dannenberg1986cmu], ESAC [@Schaffrath1997], ABC [@walshaw2011abc], Guido [@hoos1998guido], MML [@mml2001], MusicXML [@good2001musicxml], HumDrum [@huron2002music], Lilypond [@nienhuys2003lilypond] or MusicTXT [@li2021musictxt] as static languages, focus on the encoding of musical information on fixed medium while other dynamic languages such as Nyquist [@dannenberg1997machine], SuperCollider [@mccartney2002rethinking], TidalCycles [@mclean2010tidal], Sonic Pi [@aaron2016sonic], OpusModus [@opusmodus2022] and Mercury [@hoogland2019mercury] often extends musical notation by blending it with computational models of control flow, sound processing capabilities or binding different means of sonic writing: *"The instrument incorporates notational elements, but conversely the notational is becoming increasingly instrumental and systematic"* [@magnusson2019sonic].

# Objectives: Specification of a cross-platform notation system

Objectives of the Ziffers numerical notation adheres to the cognitive dimensions of music notations as defined by @nash2015cognitive and to the subset of criterion relevant to the numbered notations defined by the Music Notation Project [@mnma2022]. The notation must allow users of different ages and backgrounds to compose music. The Ziffers extension built for Sonic Pi presented in latter sections of this paper builds on the accessibility and pedagogical efforts pursued by @aaron2016sonic. The development of the numerical notation aims to remove the exclusivity that comes with the music theory and provide a beneficial live coding experience for the uninitiated. Use of numeric notation should make it possible to write melodic sequences and interval movements using numbers regardless of the key and scale. 

The implementation of the Ziffers notation is specific to each targeted platform. The notation should also minimal enough to be easily manipulated through any writing tool by relying solely on symbols taken from the ASCII table. To easily conceptualize pitches in time, defining a combination of pitch and duration should be as straightforward as possible. The notation should be able to function as an educational tool for teaching music theory and composition. Furthermore, by making the user aware of the relationship between musical and mathematical notation, the system should also support teaching advanced music theory concepts such as musical set theory and the manipulation of pitch-sets or any complex musical objects.

The number of live coding environments have steadily increased in recent years [@awesome2022]. We argue that there is now a need for some amount of notational interoperability between different live coding environments. We interpret the non coordinated emergence of Tidal-like mininotations in tools such as Gibber [@roberts2019bringing], Bacalao [@balacao2020], Petal [@petal_2019] and Hydra [@jackhydra] as an attempt from live-coders to agree on a common rhythmic pattern language despite the use of different and often highly personalized environments. In a similar fashion, the Ziffers project is hoping to bring some cross-environment support for concise and rich melodic notation. Moreover, this project can also be considered as an attempt to bridge the gap between traditional staff-based notation tools such as Avid's Sibelius, Steinberg's Dorico or Musescore and kairotic pattern notations used by live-coders. As demonstrated by the Musescore interpreter (Figure \ref{mplugin}.), Ziffers can be used both as a live and fixed-media notation, allowing any musician learning the system to quickly jot down or hear their ideas directly in any Ziffers supported software system capable of audio playback.

The Ziffers system is open for the multiple interpretations of any integer sequence. Depending on context and purpose, numbers can receive multiple interpretations, denoting musical objects such as integer notation (`0-9` and `T=10` and `E=11`), scale degrees (`1-9, 0=rest`), midi notation (`1-127`), MIDI channels (`0-15`) or even roman numerals for chord sequence writing (`i-vii`). The notation also supports commenting and providing supplementary information to clarify the meaning of any number sequence, thus adding support for the definition of custom scales, temperaments and events of any kind. The base syntax has also been designed to support common score-centric notation symbols (articulations, bar lines, repetitions) and extended generative symbols (random numbers, mathematical operations) more typically found in a live coding context. In doing so, the Ziffers system allows for some amount of transduction between different notation mediums and contexts, allowing the displacement of live coding ideas into the realm of score-based music composition. From another perspective, Ziffers also opens the field for quickly bringing musical ideas from staff-based musical notation in to the typically improvised and delayed feedback [@rohrhuber2018algorithmic] oriented performing context permitted by live coding environments.

# SONIC-PI BASED PROTOTYPE IMPLEMENTATION

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{images/architecture.png}
\caption{Ziffers architecture for Sonic Pi.}
\end{figure}

Ziffers has evolved from a simple script embedded in one of many Sonic Pi’s text buffers to a fully fledged DSL and framework for the computer aided algorithmic composition and live coding. The current software architecture for the Sonic Pi's based Ziffers implementation is presented in the figure above. A *Musescore 3.0* plugin [@ziffersmusescore2021] allowing the transformation of staff-based score format to Ziffers notation has also been created and proposed as a proof of concept tool for learning the new numeric notation.

\begin{figure}[h]
\centering
\includegraphics[width=0.9\textwidth]{images/musescore.png}
\caption{Ziffers plugin for MuseScore exporting fragment from Aphex Twin's Avril 14th score.\label{mplugin}}
\end{figure}

The plugin for the *MuseScore 3.0* be used to transform traditional scores (from MusicXML, ABC notation or MIDI files) to the numeric notation for analyzing the musical structures from your favorite composers and using the displaced sequences as a form of rehearsal and inspiration for the live coding. Examples above and below exemplifies this form of learning practice using the extracted sequence from Avril 14th by Aphex Twin. 

~~~~ {.js}
ziffers " // Aphex Twin - Avril 14th with added transformations
/ synth: piano
| q ^ 2 _ 5 ^ 0 e r s 0  | sq. 5 e 5 ^ 4 3 2 0  | / retrograde: [false,true]
| q 2 _ 5 ^ 0 e r s 0 _  | sq. _ 5 e 5 ^ 4 3 2 0  | / octave: [0,1,-1]
| e __ 0 5 ^ 0 2 _ 2 ^ 0 2 4  | e __ 3 ^ 0 3 4 _ 1 ^ 0 3 2 | / inverse: [0,1]"
~~~~

## Main methods

The **zplay**, **zloop** (z0…z20) and **zparse** methods are the main entry points to interact with Ziffers. The multiline methods, **ziff** for single playtrough and **ziffers** for looping, allows horizontal arrangement of simultanious patterns (as in the Aphex Twin example above). A slightly different version, **ztracker**, emulates the behaviour of classic music trackers (e.g. *Pro Tracker*, *Renoise*) allowing the vertical arrangement like in the *HumDrum* notation. Being non intrusive, Ziffers can also adapt to the **live_loop** mechanism defined by Sonic Pi to enable quick playback of different inputs and further enhance musical expressivity. The combined usage of **live_loop** and **zplay** methods is supported for musicians willing to use both patterning paradigms.

~~~~ {.js}
# Example of combining live_loop and zplay in Sonic Pi
with_fx :reverb, room: 1.0 do 
  live_loop :sonic_pi do
    with_synth_defaults divisor: rrand(0.1,0.15), attack: rrand(0.01,0.1) do
      pling = rrand_i(1000,3000)
      4.times do
        zplay pling, synth: :fm, scale: :mixolydian, rhythm: "q.eqe", octave: ->(){rrand_i(-1,1)}
      end
    end
  end
end
~~~~

Multiple modes of interaction with the patterning system are detailed in the [documentation](https://github.com/amiika/ziffers/wiki/Play) hosting the *Sonic Pi* implementation. Each method has its own specificities and can be adapted to a particular context of execution. For instance, composing can be supported by the non-looping zplay method while improvisation is preferably handled through the automatically synchronized zloop shorthands (each loop synchronizing on z0 unless stated otherwise). There are also various shorthands for manipulating the effects, synth parameters and playback, such as **cycle**, **fade** and **tweak** documented in the [effects section](https://github.com/amiika/ziffers/wiki/Effects).

## Parsers

Parsing is implemented with parsing expression grammars (PEGs) using the Ruby-based Treetop library (Treetop 2022). Ziffers is constituted of three parsers, each one handling specific use cases depending on the nature of the input. The **Parameter parser** is used for multiline parsing where notation can include supplementary information, such as the key, scale, synth, MIDI port, MIDI channel and other context or environment specific parameters. The **Generative parser** has been specialized to parse random number generators, sequence generators relying on various conditional statements and mathematical operations. Furthermore, an optional string rewrite loop can be used to extend these generative capabilities by transforming the input through recursive substitution of some parts of the initial input. One can think of the Ziffers parsing system as a multi-layered conditional parsing operation. After a first part of context specific or generative parsing operations, the resulting string is parsed again using the **Basic parser**, which includes only the static definitions of pitches, octaves and durations. The relevant data structures for the parsed notation are implemented as subclasses of array and hash, which implements all the necessary methods for the transformations.

## Inputs and parameters

All inputs are normalized to a string, type conversion being applied when necessary. The integer '2468' can be parsed to a sequence of notes or a chord, etc. Adjusting the base behaviour of the parser can be done by providing parameters as additional keyword arguments defining a context for the parser. In a similar fashion, user input can also be specified as a lambda function or as enumerable defined by the *Ruby* language. This is allowing for the definition and use of infinite note sequences such as the Morse-Thue sequence demonstrated below, one that is commonly used in fractal music composition [@kindermann2001musinum;@gomez2021symbolic].

~~~~ {.js}
# zplay is the fastest way to ziffer
zplay "q 0 236 q.4 e6 3 0 2", key: :g3, scale: :minor, synth: :piano
zplay 2468, key: :c3, synth: :fm, rhythm: [0.25,0.125,0.5] # Parse as a sequence
zplay 2468, key: :c3, synth: :fm, parse_chord: true # Parse as a chord
zplay [2,4,6,8], key: :E4, scale: :hex_sus, synth: :chiplead, width: 2, pan: ->(){rand} 
zplay [[1,0.5],[3,0.25],[0,1.0]], key: 60, scale: :aeolian, synth: :blade, res: 0.1

# z0-z20 are shorthands for loops
z0 "q 0 e 3 2 q 4 2", synth: :fm, divisor: [0.25,0.35,0.45]
# Lambdas can be evaluated for each loop cycle
z1 ->(){rrand_i(-9,9)}, scale: :blues_minor, synth: :kalimba, clickiness: ->(){rand}
# Morse-thue sequence defined as infinite enumerable using mod 7
z2 (0..Float::INFINITY).lazy.collect{|n|n.to_s(2).split('').count('1')%7}, rhythm:spread(7,9)
# Built-in enumerable for playing the digits of pi
z3 pi.take(10), scale: :kumoi, synth: :tb303, rhythm: 0.125, cutoff: tweak(:sine,60,100,10).reflect
~~~~

Parameters can also be used to define meaning for **control characters** `A-Z` to act as placeholders for samples or different kind of events and implementation specific functions.

~~~~ {.js}
# Use of control characters to define samples or midi
zplay "[: q K H [K K] H :4]", K: :bd_boom, H: :drum_cymbal_closed
zplay "[: q K H [K K] H :4]", K: 12, H: 90, port: "ext_midi", channel: 1
# Use of control characters to define a function call
define :foo do sample :bd_zum end # Define Sonic Pi method
z1 "q F e F F", F: :foo # Time the method using ziffers
# Use of control characters to define cue events
canon = zparse "5 4 A 3 2 B 1 0", synth: :pretty_bell, A: {cue: :c2}, B: {cue: :c3} # Simple canon
z1 canon
z2 canon, wait: :c2 # Wait for A
z3 canon, wait: :c3 # Wait for B
~~~~

## Transformations

The Transformation phase is an optional step for the manipulation of the generated musical patterns as defined by @spiegel1981manipulations, for example retrograde, inversion, substitution or by defining custom transformations that can manipulate the order, pitches, durations or any other parameters in the sequence. Transformations can be done in multiple ways and in different phases of the live composition process. Ziffers syntax also includes inline notation for transformations, that can be used for chaining multiple transformations to the defined sequences. Inline notation could also act as mechanism to transfer information about the intended transformations between different implementations. Ziffers prototype for *Sonic Pi* implements many transformations categorized as Order and Object transformations. Order transformations alter the ordering in the sequence, and can be done without modifying the internal structure of the musical objects. Object transformations can be done conditionally for each object including modifying the pitch, duration and articulations. See list of [implemented transformations](https://github.com/amiika/ziffers/wiki/Transformations) in the documentation.

~~~~ {.js}
# Transformations applied on a live sequence
z1 "e0 s 1 2 3 4 e5", inverse: [false,1,0,-1], retrograde: [true,false], swap: [0,3,2,4]

# Deferred transformations using 'zparse'
a = zparse "q 0 2 1 4"
b = a.inverse
c = a.retrograde
d = a.inverse(-1).retrograde
zplay (a*2+b+c*2+b)

# Inline variant of the above mentioned methods
z1 "((q 0 e 4 2 5 3)<inverse>(3 0 2 3))<swap>(1 3 0)", key: :g3, scale: :mixolydian
~~~~

Ziffers also implements a **string rewriting system** that is a non-deterministic Turing machine for evaluating axioms using unrestricted, context-sensitive and stochastic grammars [@mccormack1996grammar]. Rules for matching can be defined using regular expressions and substituted by using any syntax defined in the Ziffers notation. In contrast to some other common generative grammar systems [@nierhaus2009algorithmic], the substitutions made to each generation can be evaluated within a loop. This also allows rules to be added, edited and evaluated on the fly, creating a new form of rule machine that can be used in a live performance.

~~~~ {.js}
# Simple rules creating a long pattern
zplay "0", rules: {"0"=>"1 2", "1"=>"2 1", "2"=>"1 0"}, gen: 6
# Match using regex, substitute with evaluation and mod by 7
zplay "1 2 3", rules: {/[1-9]/=>"({$*2} [e,q] {$*3})%7"}, gen: 3
# Play and mutate generations on-the-fly
z1 "0", rules: {"0"=>"q 0 1", "1"=>"e (1,4) 0" }
# Change durations using rules
z2 "q0 e2 e1 q4", rules: {"q"=>"e", "e"=>"q"}
# Stochastic rules using Ziffers notation and regular expressions
z1 "q0", rules: {"q0"=>"{%>0.5?q3:q0}", "q3"=>"{%>0.25?q(3,7):q0}", /q[1-9]/=>"[q3,q0]"}
~~~~

# NOTATION

Ziffers notation is divided into basic and generative syntax. Basic notation contains the elementary building blocks for sequential and polyphonic melodies. Generative notation builds on the basic notation and includes syntax for arithmetics, logical operations and transformations. Examples in this section are written in implementation independent form and could be performed using different methods.

## Basic Notation: pitch, rhythm and silence

The Ziffers syntax is supporting many classic musical notation symbols as well as many variations in their writing. For better readability and for the sake of brevity, we have chosen to list and comment only the most commonly accessed tokens, relegating other notation symbols to the example tables. Detailed sections will cover the more advanced and Ziffers specific features. Basic notation contains all static symbols, which can be parsed without additional processing. By default, Ziffers interprets numbers as in pitch class notation `[0-9TE]`, extending numbers to capital characters `T` for `10` and `E` for `11` to support faster input for 12-tone compositions. Pitch classes higher than `9` or lower than `-9` can also be escaped using curly braces. For example, pitch classes `-12` and `24` could be notated as `{-12 24}`, which is then interpreted to the right octave depending on the scale. In a major scale number `24` becomes pitch class `3` in octave `3`. 

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{images/pc_line.png}
\caption{Pitches in integer notation.}
\end{figure}

In pitch class notation 0 represents the root for the scale. Negative pitch classes can be used to denote pitch classes below the root. Scales can be thus mentally visualized as number lines ranging from negative to positive, which then makes it easier to find the right pitch without any calculation and knowledge of the given scale. 

Alternatively, degree based interpretation can be used as a separate option, where integers from 1-9 are interpreted as scale degrees. Use of degree based notation can be easier for those who are only familiar with scale degrees and not accustomed to pitch class notation.

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{images/degree_line.png}
\caption{Pitches in degree notation.}
\end{figure}

In degree based notation, degrees range from 1 to 9 depending on the scale length. Compared with pitch class notation, the degree based notation does not have the root as a mirroring axis. Pitches can also be sharpened using **#** or flattened with **b** when using diatonic scales.

**Note durations** are denoted with lower case characters which are selected from note length names, for example **w** for whole, **h** for half, **q** for quarter, **e** for the eight note etc. In integer notation, silence is defined using the character **r** for rest. In degree based notation, 0 is also treated as silence, as used in the Galin-Paris-Chevé notation [@dauphin2012devenir]. Characters for nearby triplet notes have been selected on the basis of the close proximity on the qwerty keyboard. See the full [list of duration characters](https://github.com/amiika/ziffers/wiki/Melody#list-of-all-note-length-characters) in the documentation. Alternatively, decimals can be used instead of characters. Dotted lengths are used as in traditional musical notation to increase the note duration. Similarly, decimal notation can be used as an alternative to letter-based durations and dots, especially for venturing outside of the traditional note lengths. For example, famous nursery rhyme *Row row row your boat* could be notated differently depending on the chosen duration syntax:

~~~~ {.js}
// Use of note length characters and dots for durations
| q. 0 0 | q0 e1 q.2 | q2 e1 q2 e3 | h4 qr | e 7 7 7 4 4 4 | 2 2 2 0 0 0 | q4 e3 q2 e1 | h. 0 |
// Use of decimal notation for durations
| 0.375 0 0 | 0.25 0 0.125 1 0.375 2 | 0.25 2 0.125 1 0.25 2 0.125 3 | 0.5 4 0.25 r | // …
~~~~

**Key** is determined from given parameters or from inline notation denoted by either MIDI notes, note names or scientific pitch notation. **Scale** is determined from the predefined scale names or by defining custom scales using an array of intervals where `1` represents semitone and `2` tone, or by using decimals for intervals smaller than a semitone. **Octaves** can be changed using special characters `_` for lowering and `^` for raising the octave or by using escaped integers `<3>` to define the exact octave. Octaves can be changed using negative integers which also keep the relative distance when for example, the scale is changed from minor to minor pentatonic. Consider following measures in both keys: `| 0 3 -1 2 | 0 3 _6 2 |`. In minor scale both measures are exactly the same, but since minor pentatonic has only 5 scale degrees there is a difference in how the `_6` is interpreted compared to `-1`. 

**Chords** are typically represented by using number groups. The basic diatonic major chord can thus be represented as 024 in diatonic context, and as 047 in a chromatic context. Pitches in chords can be defined in different octaves combining the notation for example `024^0 _12<1>4`. **Whitespace** acts as a separator for different objects, like the chords in a sequence. **Chord inversions** can be amended using the `%` symbol in combination with a chord `024%2`. Roman numerals are also supported as part of the extended syntax for chord writing based on tonal/diatonic techniques. 

~~~~ {.js}
// Example harmonization of 'Row row row your boat' using different symbols to modify pitches
| q. 047 0                | q0 e1 q.2      | q0247 e1 q2 e3         | h4 qr      |
| e 0b24^0 ^ 0 0 _ 4 4 4  | e 2 2 2 0 0 0  | q<-2>4<-1>44 e3 q2 e1  | h._0024%-1 |
~~~~

**Articulations**, such as staccato ' and accents \` ´ can be used to affect the amplitude and the duration of the pitches. Defining **Measures** is optional but can prove necessary if there is a need to access them in different order. They are denoted using the pipe character `|` and each such character always resets the current octave and note length to the default value. This is important for both human and a machine to be able to start from any given measure without having the need to retrace to the beginning of the arrangement. **Comments** can be included using `//` or `/* */` characters. 

~~~~ {.js}
// This is a comment                 // One-line comments in Ziffers notation
/* This is a multiline comment */    // Multiline comments
<d3> 0 2 3 <minor> 0 2 3             // Inline key and scale
| h 0 ^ q. 4 e 2 | q. 4 h 6 e 2 |    // Measures
024 146 025%-1 35^0                  // Chords (i v vi iv)
``0 `0 0 ´0 ´´0                      // Accents (` softer and ´ louder amp.)
0 '0 ''0                             // Staccato (shortened duration)
~<0.3>0123456                        // Glissando/bends (with speed param.)
{decay: 0.5}  1 {port: ext_2} 3      // Hash notation for inline parameters
~~~~

## Generative notation

Repetition is the simplest form of generative syntax also used by the traditional staff notation. **Repeats** are denoted using dotted list notation `[:  :]` which is by default repeated two times. Repeats can also be nested which is useful for creating the minimal representation of repeating tunes like the *Frère Jacques*.

~~~~ {.js}
[: q 0 1 2 0 :] [: q 2 3 h4 :] [: [: e 4 5 4 3 q 2 0 :] [: q 0 _4 h0 :] :] // Frère Jacques
[: q0 e1 q.2 :4]     // Repeat 4-times
[: (0,3) (4,6) :6]   // Repeat the same generated sequence 6-times
~~~~

**Random numbers** are the basic building blocks of all aleatoric melodies. There are multiple ways of defining random integers and decimals in the generative syntax and the generated values can be used for different purposes. Number sequences can be generated using range notation inspired by the Ruby syntax which has been updated to be more versatile.

~~~~ {.js}
(0.25,0.5) (0,5)            // Random decimal and pitch between defined range
% ?                         // % = (0.01,1.0) ? = (0,scale length)
[0.125,0.25,0.5] [0,2,4,6]  // Random numbers from selection
-1..1                       // -1 0 1
0..3+2                      // 0 2
0..3*2                      // 0 2 4 
?..(3,5)                    // 5..3 => 5 2 3
~~~~

**Lists** syntax can be used to arrange pitches into operable sequences. Arithmetic operations `+ - * ** / ^ % | & << >>` can be applied to list values in a serial manner. Arithmetic operations can also be applied between two lists creating cartesian operations. To produce long alternating patterns arithmetic operations can also be chained together. There are also 5 special methods that have designated short-hand symbols. Combine **&** for creating a chord out of list, separate **$** for creating the sequence from a chord, unique **!** for removing same pitches from the list, pick a random **?** for picking 1-n pitches from the list and shuffle **~** for shuffling and picking unique random values from the list. 

~~~~ {.js}
(q 0  e 1 2 q 3 5)+1*4%7                // Applying multiple operations to a list
(1 2)+(3 4)                             // Same as: 1+3 1+4 2+3 2+4
(q 0  e 1 2 q 3 5)+(3 0 -2 3)-(2 1 3 4) // Lists and operations can be chained
(: (1,4) :3)                            // Generate 3 different random numbers
(:(0,6):3)& 
~~~~

**Bracket syntax** is alternative notation for durations that subdivides the note lengths using nested brackets. Similar notation is also used by TidalCycles and Alda. Bracket syntax is especially useful for notating triplets or n-tuplets. 

~~~~ {.js}
q [0 2 [3 [5 [2 0]]]] // Nested brackets
// Frere Jacques using the bracket syntax
w [: [0 1 2 0] :] [: [[2 3] 4] :] [:[: [[4 5] [4 3] 2 0] :] [: [[0 _4] 0] :]:]
~~~~

**Cyclic notation** for events has been previously introduced by TidalCycles. Cyclic structures can be defined by enclosing the sequence in nested angle brackets. Ziffers enables the use of cyclic notation in loops or as part of repeat notation as alternative endings also used in the traditional staff notation. When cycles are defined within a repeat notation, the cycles are evaluated within the context of the repeat.

~~~~ {.js}
<1 2 <3 <4 5>>>               // Cyclic notation for loops
[: 1 <2 4> :]                 // Alternate endings for repeat
(: (1,7) <2 <4 5>> :3)        // Cyclic notation in list repeat
(1 [2 <4 5>] 024)+(<2 0> 1 2) // Bracket and cyclic notation in a list
(1 2 3)+<(1 2) (4 6)>         // Operations with cyclic lists
(0 <1 2>)<+ - *><0 1 2>       // Cyclic everything
~~~~

**Transformations** can also be notated inline using the list syntax and escape notation for built-in methods: `(list)<method>(optional-list)`. Ziffers also implements numerous shorthand notations for useful transformations, like **cyclic zip** for combining values from two lists, notation for **pitch-class set multiplication** [@heinemann1998pitch] and **sequence interpolation** inspired by the Thesaurus of scales and melodic patterns [@slonimsky1986thesaurus]. **Generative repeat** syntax can be used to generate values multiple times, whereas normal repeats are used to repeat the generated values and create a sense of repetition. **List functions** are inspired by polynomial functions and can be used to transform the values using arithmetic expressions. 

~~~~ {.js}
(1 2 3)<retrograde>          // Inline transformation
(1 2 3)<inverse>(-1 2 0)   	 // Multiple chained transformations
(q e e)<>(0..5)              // Cyclic zip: q 0 e 1 q 2 e 3 q 4 
(1 2)<+>(3 4 5)              // Product of two lists: 1 3 1 4 1 5 2 3 2 4 2 5 
(0 5)<*>(0 3 6 9)            // Pitch-class set multiplication: 0 5 3 8 6 {11} 9 {14}
(1 3)<4>(1 3)                // Interval interpolation: 2 4 6 1 3 5 
q (0..3){(2x-1)(2x^2-4)}     // Using function to transform a list
((1,5)){x<2?(x+3):(2x)(x-2)} // Applying functions conditionally 
~~~~

**Chords** can be generated using roman numerals `(i-vii)` and further modified using chord names, inversions and modal interchange. **Chord names** are defined using the caret symbol and the corresponding name, for example: `i^dim7`. Chord names are based on Sonic Pi's definitions and further standardization would be needed to include more chord names and to harmonize varying naming practices. Chords can also be inverted using `%` symbol, for example `iv%-2`. Tri-chords can also be built by defining number of pitches `{i-vii}+{number of pitches}`, for example `ii+6`. **Borrowed chords** can be created using shorthand characters for modes `(a-g)` combined with the roman numerals, for example: `iib` (locrian), `iiig` (mixolydian). Chords can also be generated from lists using combine **&** shorthand that transforms sequences to chords, for example: `((10,100) (100,1000))&` or `((4..7)*4)&`. **Arpeggios** can be generated by defining sequences of chords and selecting pitches from the list using the ampersand **@**-operator or by selecting values horizontally from the list using the **#**-operator.

~~~~ {.js}
i ii iii iv v vi vii              // Supported roman numerals
i v%1 vi%-1 iv%-1                 // With inversions
i^7 iv^dim v^maj9%-2              // With names and inversions
(i v vi%-1 iv%-1)@(e 0 1 2 012)   // Arpeggio from Roman numerals
024 146 025%-1 35^0)@(q 1 0 2 0)  // Arpeggio from pitch groups
(0 2 4 6)#(e 0 1 2 012)           // Horizontal arpeggio
~~~~

Expressions can be **evaluated** using curly braces: `{...}`, which can be used for escaping pitches, arithmetic operations or conditional logic. Using ternary operator syntax `(cond)?(true):(false)` it is possible to define alternative or conditional parts. 

~~~~ {.js}
{10 11 9+2 3*5}         // Evaluate as pitches
={10 (10,20) 3*5}       // Evaluates as chords
{%>0.5?3}               // Single conditional pitch
{(0,9)>4?(1,3):(3,6)}   // Random numbers based on condition
{%>0.5?4 %>0.2?5:3}     // Multiple conditionals 
~~~~

**Euclidean rhythms** have gained popularity among music composers [@morrill2022euclidean] for some years after Godfried Toussaint first presented the idea of using euclidean algorithm to generate rhythms from binary sequences [@bridges2005]. *Sonic Pi* also implements the euclidean algorithm as a spread method named after the evenly spread boolean. Ziffers has its own approach to euclidean patterns and implements an algorithm defined by Thomas Morrill [@morrill2022euclidean] and a novel syntax that can be used to combine both onset and offset values from the binary sequence. Syntax for the euclidean generator is defined as an operator for one or two lists:  `(onset)<beats,total,rotate>(offset)`. Values will be selected from onset or offset list according to the binary sequence generated by the euclidean algorithm. Default offset value is a rest, but it can be replaced with a list of alternative offset values. Both onset and offset lists can include any syntax defined in the numeric notation. Values in the list will overflow to the beginning if there are not enough values for the whole cycle. Inner cycles can also be defined using cyclic syntax, to make more complex structures. 

~~~~ {.js}
s (0 3 2 5)<5,7>                  // Offset defaults to r 
s (<0 <3 <5 (-3,3)>>>)<3,6>       // Nested cycles
(q0 q2)<3,5>((e 3 4) (e 1 4))     // Pitches from the onset and lists from the offset
(eX sB)<13,16>(eB sX)             // Spread samples or events
~~~~

Generated patterns can be assigned to **inline variables** -- denoted using capital letters -- for adding structure and predictability to the live-coded composition. These variables can be used to replace parts of the syntax and to create musical form by devising reoccurring segments. Limiting the introduction of new patterns and repeating the segments supports familiarity and evokes positive responses in the listeners [@huron2008sweet]. Using the same musical form for gradual variation -- among with carefully planned surprises -- enables the live-coder to manage the expectations and gives the listeners satisfaction from anticipating and successfully predicting the patterns.

~~~~ {.js}
A=% {A>0.5?(e 1 2):(q2)} {A<0.5?4:5}                             // Use in conditional statements
A=<1 2 <3 <6 7>>> B=(1,6) B A B B A                              // Define repetition
A=(0 (1,6) 3)+(1,3) B=(0 [-2,1,2]) A A B A                       // Create contrasting sections
A=(0 3 [2 4]) B=(A)<retrograde> C=(B)<inverse>(3) A B C          // Store transformations
A=(0 2 [3 2])+<0 <2 1>> B=(0 (1,5) [3 <(2,5) (0,3)>]) A B B A    // Combine everything
~~~~

# Conclusion and future work

In this paper, we have presented a novel numeric notation and a pattern language usable in a live coding context. The presented notation is designed as a bridge from the old to the new, linking and facilitating exploration between different forms of computer and staff-based musical notation; from pitch-based staff writing to generative and improvised performance. The Ziffers notation is designed to be platform independent, making it possible to share generative melodies and patterns between different live coding languages and more traditional composition tools. Even though Ziffers as a language is expressive enough to describe arbitrarily complex musical sequences using mathematical and generative operations, profound and meaningful interaction is still to be found in the link between Ziffers and the underlying logic and flow centered operation of live coding interfaces implementing it. Further experimentation is still needed to find the perfect balance between the proposed numbered notation and different live coding languages.

For now, Sonic Pi is the only fully supported platform for Ziffers. Due to a planned change from Ruby to Elixir programming language, the current implementation might become unsupported in the future. By then, the implementation needs to be rewritten, but it has also already served its purpose as an exploratory medium for prototyping numbered notation in live coding. It is also always possible to use Ziffers with the latest *Sonic Pi* version with the *Ruby* support.

As a future work, we intend to develop parsers in other live coding libraries such as Sardine [@forment2022], SuperCollider and others. An upgrade for the MuseScore plugin is also planned to the upcoming MuseScore version 4.0, as a way to support the input of the generative numeric notation directly to traditional sheet music and create a hybrid algorithmic composition environment for both numbered and standard notation. We envision that the proposed notation can also be used as a tool for teaching music analysis and pitch-class set theory and act as a stepping stone between music theory and live coding.  


# Acknowledgment

Authors would like to thank Sam Aaron and the whole Sonic Pi community for the important work on improving the pedagogy and accessibility of programming and for the inspiration to pursue research in the field of live coding. Raphaël would like to thank Laurent Pottier and Alain Bonardi for their support, as well as the doctoral school *3LA* from the University of Lyon for the funding it provided to this research.

# References
