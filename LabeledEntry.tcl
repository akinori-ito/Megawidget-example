package provide LabeledEntry 0.1
package require ComposedWidget

tk::Megawidget create LabeledEntry ComposedWidget {
   variable w hull options forwardlist
   method Create {} {
     variable lblopt entopt bothopt
     set lblopt {-activebackground -activeforeground -anchor -bitmap -compound -height -highlightbackground 
                      -image -justify -relief -underline -padx -pady -text -wraplength }
     set bothopt {-background -borderwidth -cursor -font -foreground -highlightcolor -highlightthickness
                      -state -takefocus}
     set entopt  {-disabledbackground -exportselection -highlightbackground -insertbackground
                           -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd
                           -readonlybackground -selectbackground -selectborderwidth -selectforeground -show
                            -textvariable -validate -validatecommand -vcmd -width -xscrollcommand}

     label $hull.lbl
     entry $hull.ent
     set forwardlist [list $hull.lbl [concat $lblopt $bothopt] $hull.ent [concat $entopt $bothopt]]
     $w forwardoption
     pack $hull.lbl $hull.ent -side left
   }
   method get {} {return [$w forward ent get {}]}
   method insert {args} {return [$w forward ent insert $args]}
   method delete {args} {return [$w forward ent delete $args]}
   method GetSpecs {} {return {
      {-activebackground activeBackground Foreground SystemButtonFace SystemButtonFace}
      {-activeforeground activeForeground Background SystemButtonText SystemButtonText}
      {-anchor anchor Anchor center center}
      {-bitmap bitmap Bitmap {} {}}
      {-compound compound Compound none none}
      {-height height Height 0 0} {-highlightbackground highlightBackground HighlightBackground SystemButtonFace SystemButtonFace}
      {-image image Image {} {}}
      {-justify justify Justify center center}
      {-relief relief Relief flat flat}
      {-padx padX Pad 1 1}
      {-pady padY Pad 1 1}
      {-text text Text {} {}}
      {-underline underline Underline -1 -1}
      {-wraplength wrapLength WrapLength 0 0}
      {-background background Background SystemButtonFace SystemButtonFace}
      {-borderwidth borderWidth BorderWidth 2 2}
      {-cursor cursor Cursor {} {}} 
      {-font font Font TkDefaultFont TkDefaultFont}
      {-foreground foreground Foreground SystemButtonText SystemButtonText}
      {-highlightcolor highlightColor HighlightColor SystemWindowFrame SystemWindowFrame}
      {-highlightthickness highlightThickness HighlightThickness 0 0}
      {-state state State normal normal}
      {-takefocus takeFocus TakeFocus 0 0}
      {-disabledbackground disabledBackground DisabledBackground SystemButtonFace SystemButtonFace}
      {-exportselection exportSelection ExportSelection 1 1}
      {-highlightbackground highlightBackground HighlightBackground SystemButtonFace SystemButtonFace}
      {-insertbackground insertBackground Foreground SystemWindowText SystemWindowText}
      {-insertborderwidth insertBorderWidth BorderWidth 0 0}
      {-insertofftime insertOffTime OffTime 300 300}
      {-insertontime insertOnTime OnTime 600 600}
      {-insertwidth insertWidth InsertWidth 2 2}
      {-invalidcommand invalidCommand InvalidCommand {} {}}
      {-invcmd invalidCommand InvalidCommand {} {}}
      {-readonlybackground readonlyBackground ReadonlyBackground SystemButtonFace SystemButtonFace}
      {-selectbackground selectBackground Foreground SystemHighlight SystemHighlight}
      {-selectborderwidth selectBorderWidth BorderWidth 0 0}
      {-selectforeground selectForeground Background SystemHighlightText SystemHighlightText}
      {-show show Show {} {}}
      {-textvariable textVariable Variable {} {}}
      {-validate validate Validate none none}
      {-validatecommand validateCommand ValidateCommand {} {}}
      {-vcmd validateCommand ValidateCommand {} {}}
      {-width width Width 20 20}
      {-xscrollcommand xScrollCommand ScrollCommand {} {}}
     }
   }
}
