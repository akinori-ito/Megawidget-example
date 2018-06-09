package provide DualListbox 0.1
package require ComposedWidget

tk::Megawidget create DualListbox ComposedWidget {
  variable w hull options forwardlist
  method Create {} {
     variable opt0 opt1 myopt
     set opt0 {-activestyle -background -borderwidth -cursor -disabledforeground
               -exportselection -font -foreground -height -highlightbackground
               -highlightcolor -highlightthickness -justify -relief -selectbackground
               -selectborderwidth -selectforeground -selectmode -setgrid -state -takefocus
               -xscrollcommand -yscrollcommand}
     set opt1 $opt0
     set myopt {-width -listvariable}
     listbox $hull.list0
     listbox $hull.list1
     set forwardlist \
       [list $hull.list0 $opt0 \
             $hull.list1 $opt1 \
             $w $myopt]
     $w forwardoption
     grid $hull.list0 -column 0 -row 0 -sticky news
     grid $hull.list1 -column 1 -row 0 -sticky news
  }
  method configure {optsw val} {
    switch $optsw {
      -width {
        if {[llength $val] == 2} {
          $hull.list0 configure -width [lindex $val 0]
          $hull.list1 configure -width [lindex $val 1]
        } else {
          $hull.list0 configure -width $val          
        }
      }
      -listvariable {
        if {[llength $val] == 2} {
          $hull.list0 configure -listvariable [lindex $val 0]
          $hull.list1 configure -listvariable [lindex $val 1]
        } else {
          $hull.list0 configure -listvariable $val          
        }        
      }
      default {
        next $optsw $val
      }
    }
  }
  method spread {args} {
     $hull.list0 {*}$args
     $hull.list1 {*}$args
  }
  method activate {index} {$w spread activate $index}
  method bbox {index} {
    my variable bb1 bb2
    set bb1 [$hull.list0 bbox $index]
    set bb2 [$hull.list1 bbox $index]
    return [list [lindex $bb1 0] [lindex $bb1 1] [lindex $bb2 2] [lindex $bb2 3]]
  }
  method curselection {} {
    return [$hull.list0 curselection]
  }
  method delete {args} {$w spread delete {*}$args}
  method get {args} {return [$hull.list0 get {*}$args]}
  method index {ind} {return [$hull.list0 index $ind]}
  method insert {args} {
    set widget $hull.list0
    if {[lindex $args 0] eq "-column"} {
       set widget $hull.list[lindex $args 1]
       set args [lreplace $args 0 1]
    }
    $widget insert {*}$args
  }
  method selection {args} {return [$w spread selection {*}$args]}
  method size {} {return [$hull.list0 size]}
  method xview {args} {$w spread xview {*}$args}
  method yview {args} {$w spread yview {*}$args}

  method GetSpecs {} {
    return {{-activestyle activeStyle ActiveStyle underline underline} 
            {-background background Background SystemWindow SystemWindow} 
            {-borderwidth borderWidth BorderWidth 1 1} 
            {-cursor cursor Cursor {} {}} 
            {-disabledforeground disabledForeground DisabledForeground SystemDisabledText SystemDisabledText} 
            {-exportselection exportSelection ExportSelection 1 1} 
            {-font font Font TkDefaultFont TkDefaultFont} 
            {-foreground foreground Foreground SystemButtonText SystemButtonText} 
            {-height height Height 10 10} 
            {-highlightbackground highlightBackground HighlightBackground SystemButtonFace SystemButtonFace} 
            {-highlightcolor highlightColor HighlightColor SystemWindowFrame SystemWindowFrame} 
            {-highlightthickness highlightThickness HighlightThickness 1 1}
            {-justify justify Justify left left}
            {-relief relief Relief sunken sunken}
            {-selectbackground selectBackground Foreground SystemHighlight SystemHighlight}
            {-selectborderwidth selectBorderWidth BorderWidth 0 0}
            {-selectforeground selectForeground Background SystemHighlightText SystemHighlightText}
            {-selectmode selectMode SelectMode browse browse}
            {-setgrid setGrid SetGrid 0 0}
            {-state state State normal normal}
            {-takefocus takeFocus TakeFocus {} {}}
            {-width width Width 20 20}
            {-xscrollcommand xScrollCommand ScrollCommand {} {}}
            {-yscrollcommand yScrollCommand ScrollCommand {} {}}
            {-listvariable listVariable Variable {} {}}
           }
  }
}

