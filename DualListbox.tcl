package provide DualListbox 0.1

tk::Megawidget create DualListbox tk::SimpleWidget {
  variable w hull options
  method Create {} {
     my variable i arg1 arg2
     set arg1 {}
     set arg2 {}
     foreach {optsw val} [array get options] {
        switch $optsw {
        -width               {
           lappend arg1 $optsw
           lappend arg2 $optsw
           if {[llength $val] > 1} {
              lappend arg1 [lindex $val 0]
              lappend arg2 [lindex $val 1]
           } else {
              lappend arg1 $val
              lappend arg2 $val
           }
        }
        -listvariable        {
           if {[llength $val] > 1} {
              lappend arg1 -listvariable
              lappend arg2 -listvariable
              lappend arg1 [lindex $val 0]
              lappend arg2 [lindex $val 1]
           } else {
              lappend arg1 -listvariable
              lappend arg1 $val
           }
        }
        default    {
           lappend arg1 $optsw
           lappend arg2 $optsw
           lappend arg1 $val
           lappend arg2 $val
        }
        }
     }
     eval [concat listbox $hull.list0 $arg1]
     eval [concat listbox $hull.list1 $arg2]
     grid $hull.list0 -column 0 -row 0 -sticky news
     grid $hull.list1 -column 1 -row 0 -sticky news
  }
  method spread {args} {
     eval [concat $hull.list0 $args]
     eval [concat $hull.list1 $args]
  }
  method activate {index} {[self] spread activate $index}
  method bbox {index} {
    my variable bb1 bb2
    set bb1 [$hull.list0 bbox $index]
    set bb2 [$hull.list1 bbox $index]
    return [list [lindex $bb1 0] [lindex $bb1 1] [lindex $bb2 2] [lindex $bb2 3]]
  }
  method curselection {} {
    return [$hull.list0 curselection]
  }
  method delete {args} {eval [concat [self] spread delete $args]}
  method get {args} {return [eval [concat $hull.list0 get $args]]}
  method index {ind} {return [$hull.list0 index $ind]}
  method insert {args} {
    set widget $hull.list0
    if {[lindex $args 0] eq "-column"} {
       set widget $hull.list[lindex $args 1]
       set args [lreplace $args 0 1]
    }
    eval [concat $widget insert $args]
  }
  method selection {args} {return [eval [concat [self] spread selection $args]]}
  method size {} {return [$hull.list0 size]}
  method xview {args} {eval [concat [self] spread xview $args]}
  method yview {args} {eval [concat [self] spread yview $args]}

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

