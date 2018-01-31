require "rsec"
require "pp"
include Rsec::Helpers

# can't cope with more than one start in a grammar

$defs = {}
def ebnf_parse

  # [28a]   NameStartChar	   ::=   	":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
  # [28b]   	NameChar	   ::=   	NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
  # [28c]   	Name	   ::=   	NameStartChar (NameChar)*
  # [28d]   	Names	   ::=   	Name (#x20 Name)*
  # [28e]   	Nmtoken	   ::=   	(NameChar)+
  # [28f]   	Nmtokens	   ::=   	Nmtoken (#x20 Nmtoken)*
  # [28g] 	Char	   ::=   	#x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
  #
  char = /[\u0009\u000a\u000d\u0020-\u00ff]/.r
  name = /[:A-Z_a-z\u00c0-\u00d6\u00d8-\u00f6\u00f8-\u00ff][:A-Z_a-z\u00c0-\u00d6\u00d8-\u00f6\u00f8-\u00ff.0-9\u00b7-]*/.r
  nmtoken = /[[:A-Z_a-z\u00c0-\u00d6\u00d8-\u00f6\u00f8-\u00ff.0-9\u00b7-]]+/.r

  # [28] NCName ::= Name - (Char* ':' Char*)

  cname = /[\u0009\u000a\u000d\u0020-\u0039\u003b\u00ff]+:[\u0009\u000a\u000d\u0020-\u0039\u003b\u00ff]+/.r
  ncname = seq( ''.r ^ cname, name)

  # [22] CName ::= NCName ":" NCName
  # [23] nsName ::= NCName ":*"

  #cname = seq(ncname, /:/.r, ncname)
  nsname = seq(ncname, /:\*/.r)

  # [24] anyName ::= "*"
  # [25] literal ::= literalSegment+
  # [26] literalSegment ::= '"' (Char - '"')* '"' | "'" (Char - "'")* "'"

  anyname = /\*/.r
  literalSegment = /"[^"]*"/.r | /'[^']*'/.r
  literal = literalSegment * (1..-1)

  # [18] inherit ::= "inherit" "=" identifierOrKeyword
  # [19] identifierOrKeyword ::= identifier | keyword
  # [20] identifier ::= (NCName - keyword) | quotedIdentifier
  # [21] quotedIdentifier ::= "\" NCName
  # [27] keyword ::= "attribute" | "default" | "datatypes" | "div" | "element" | "empty" | "externalRef" | "grammar" | "include" | "inherit" | "list" | "mixed" | "namespace" | "notAllowed" | "parent" | "start" | "string" | "text" | "token"

  keyword = /attribute/.r | /default/.r | /datatypes/.r | /div/.r | /element/.r | /empty/.r | /externalRef/.r | /grammar/.r | /include/.r | /inherit/.r | /list/.r | /mixed/.r | /namespace/.r | /notAllowed/.r | /parent/.r | /start/.r | /string/.r | /text/.r | /token/.r
  quotedIdentifier = seq('\\', ncname)
  identifier = seq(''.r ^ keyword, ncname) | quotedIdentifier
  # identifierOrKeyword = identifier | keyword
  identifierOrKeyword = ncname
  inherit = seq_(/inherit/.r, /=/.r, identifierOrKeyword)

  # [11] nameClass ::= name | nsname [exceptNameClass] | anyname [exceptNameClass] | nameClass "|" nameClass | "(" nameClass ")"
  # [12] name ::= identifierOrKeyword | CName
  # [13] exceptNameClass ::= "-" nameClass
  # [14] datatypeName ::= CName | "string" | "token"
  # [15] datatypeValue ::= literal
  # [16] uri ::= literal
  # [17] namespaceUri ::= literal | "inherit"

  name = identifierOrKeyword | cname
  nameClass1 = seq_(/\|/.r, lazy{nameClass}) * (1..-1)
  nameClass = seq_(name, nameClass1._?) |
    seq_(nsname, lazy{exceptNameClass}._? , nameClass1._?) |
    seq_(anyname, lazy{exceptNameClass}._?, nameClass1._?) |
    #seq_(lazy{nameClass}, /\|/.r, lazy{nameClass} ) |
    seq_(/\(/.r, lazy{nameClass}, /\)/.r, nameClass1._?)
=begin
  nameClass = name | 
    seq_(nsname, lazy{exceptNameClass}._? ) | 
    seq_(anyname, lazy{exceptNameClass}._?) | 
    seq_(lazy{nameClass}, /\|/.r, lazy{nameClass} ) | 
    seq_(/\(/.r, lazy{nameClass}, /\)/.r)
=end
  exceptNameClass = seq_(/-/.r, nameClass)
  datatypeName = cname | /string/.r | /token/.r
  datatypeValue = literal
  uri = literal
  namespaceUri = literal | /inherit/.r

  # [2] decl ::= "namespace" identifierOrKeyword "=" namespaceUri |
  #         "default" "namespace" [identifierOrKeyword] "=" namespaceUri |
  #         "datatypes" identifierOrKeyword "=" literal

  decl = seq_(/namespace/.r, identifierOrKeyword, /=/.r, namespaceUri ) |
    seq_(/default/.r, /namespace/.r, identifierOrKeyword._?, /=/.r, namespaceUri) |
    seq_(/datatypes/.r, identifierOrKeyword, /=/.r, literal)

  # [4] param ::= identifierOrKeyword "=" literal
  # [10] assignMethod ::= "=" | "|=" | "&="
  # [8] start ::= "start" assignMethod pattern
  # [9] define ::= identifier assignMethod pattern
  # [7] includeContent ::= define | start | "div" "{" includeContent* "}"
  # [5] exceptPattern ::= "-" pattern

  param = seq_(identifierOrKeyword, /=/.r, literal)
  assignMethod = /=/.r | /\|=/.r | /\&=/.r
  start = seq_(/start/.r, assignMethod, lazy{pattern}).map { |t| t.join(' ') }
  define = seq_(identifier, assignMethod, lazy{pattern}).map do |id, eq, p| 
    $defs[id] = [id, eq, p].join(' ') 
    []
  end
  includeContent = define | start | seq_(/div/.r, /\{/.r, lazy{includeContent}.star, /\}/.r)
  exceptPattern = seq_(/-/.r, lazy{pattern})

  # [6] grammarContent ::= start | define | "div" "{" grammarContent* "}" | "include" uri [inherit] ["{" includeContent* "}"]

  grammarContent = start | 
  define |
  seq_(/div/.r, /\{/.r, lazy{grammarContent}.star, /\}/.r) |
  seq_(/include/.r, uri, inherit._?, seq_(/\{/.r, includeContent.star,  /\}/.r))

  # [1] topLevel ::= decl* (pattern | grammarContent*)
  # [3] pattern ::= "element" nameClass "{" pattern "}" | 
  # "attribute" nameClass "{" pattern "}" | 
  # pattern ("," pattern)+ | 
  # pattern ("&" pattern)+ | 
  # pattern ("|" pattern)+ | 
  # pattern "?" | 
  # pattern "*" | 
  # pattern "+" | 
  # "list" "{" pattern "}" | 
  # "mixed" "{" pattern "}" | 
  # identifier | 
  # "parent" identifier | 
  # "empty" | 
  # "text" | 
  # [datatypeName] datatypeValue | 
  # datatypeName ["{" param* "}"] [exceptPattern] | 
  # "notAllowed" | 
  # "externalRef" uri [inherit] | 
  # "grammar" "{" grammarContent* "}" | 
  # "(" pattern ")"

=begin
  pattern = seq_(/element|attribute/.r, nameClass, /\{/.r, lazy{pattern}, /\}/.r) |
    seq_(lazy{pattern}, seq_( /[,&|]/.r, lazy{pattern}) * (1..-1) ) |
    seq_(lazy{pattern}, /[?*+]/.r) |
    seq_(/list|mixed/.r, /\{/.r, lazy{pattern}, /\}/.r ) |
    seq_(identifier ) |
    seq(/empty|text|notAllowed/.r ) |
    seq_(/parent/.r, identifier ) |
    seq_(datatypeName._?, datatypeValue )| 
    seq_(datatypeName, seq_(/\{/.r, param.star, /\}/.r)._?, exceptPattern._? )|
    seq_(/externalRef/.r, uri, inherit._? )|
    seq_(/grammar/.r, /\{/.r, grammarContent.star, /\}/.r )|
    seq_(/\(/.r, lazy{pattern}, /\)/.r )
=end
  pattern1 = seq_( /[?*+]/.r._?, /[,&|]/.r, lazy{pattern}) * (1..-1) | /[?*+]/.r
  grammartail = seq_(/\}/.r, pattern1._?).map { |x, p| "INSERT_HERE\n}\n#{p[0]}" } | 
    seq_(grammarContent, lazy{grammartail}).map {|t| t.join(' ') }
  pattern = seq_(/element/.r, nameClass, /\{/.r, lazy{pattern}, /\}/.r, pattern1._?).map { |t| t.join(' ')  + "\n" } |
    seq_(/attribute/.r, nameClass, /\{/.r, lazy{pattern}, /\}/.r, pattern1._?).map { |t| t.join(' ') } |
    seq_(/list|mixed/.r, /\{/.r, lazy{pattern}, /\}/.r , pattern1._?).map { |t| t.join(' ')  + "\n" } |
    # seq_(/grammar/.r, /\{/.r, grammarContent.star, /\}/.r , pattern1._?).map { |t| t.join(' ')  + "\n" } |
    seq_(/grammar/.r, /\{/.r, grammartail).map { |t| t.join(' ')  + "\n" } |
    seq_(identifier , pattern1._?).map { |t| t.join(' ')   } |
    seq(/empty|text|notAllowed/.r , pattern1._?).map { |t| t.join(' ')  } |
    seq_(/parent/.r, identifier , pattern1._?).map { |t| t.join(' ')  } |
    seq_(datatypeName._?, datatypeValue , pattern1._?).map { |t| t.join(' ')   }|
    seq_(datatypeName, seq_(/\{/.r, param.star, /\}/.r)._?, exceptPattern._? , pattern1._?).map { |t| t.join(' ')   }|
    seq_(/externalRef/.r, uri, inherit._? , pattern1._?).map { |t| t.join(' ')  + "\n" }|
    seq_(/\(/.r, lazy{pattern}, /\)/.r , pattern1._?).map { |t| t.join(' ')   }
  topLevel = seq_(decl.star, pattern, /\s*/.r).map do |d, t| 
    $decl = d.join(" ")
    t#.join (' ') + "\n"
  end | seq_(decl.star, grammarContent * (1..-1) , /\s*/.r).map do |d, t|
    $decl = d.join(" ")
    t.join (' ') + "\n"
  end
  fred = seq_(/default/.r, /namespace/.r, identifierOrKeyword.maybe, /=/.r, namespaceUri, /\s*/.r)
  fred1 = seq_(pattern, /\s*/.r)

  topLevel.eof
end

def parse(filename)
  grammar = File.read(filename).gsub(/\s*$/m, "").lines.reject { |l| l =~ /^\s*#/ }.join("")
    @ctx = Rsec::ParseContext.new grammar, 'source'
  ret = ebnf_parse._parse @ctx
  if !ret or Rsec::INVALID[ret]
    raise @ctx.generate_error 'source'
  end
  ret
end

ret1 = parse(ARGV[0])
# incredibly, I can't detect start, so I have to extract it
m = /\b(?<start>start\s+=\s+\S+)/m
$defs1 = $defs
$defs = {}
ret2 = parse(ARGV[1])
matched = m.match ret2
start = matched[:start]
out = ""
$defs1.merge($defs).each { |k, v| out += v }
ret1.gsub!(m, start)
ret2.gsub!(m, "")
ret1.gsub!(/INSERT_HERE/, out)
puts $decl
puts ret1
puts ret2
out = ""
$defs1.merge($defs).each { |k, v| out += v }


