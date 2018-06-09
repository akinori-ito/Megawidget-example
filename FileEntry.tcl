package provide FileEntry 0.1
package require ComposedWidget

tk::Megawidget create FileEntry ComposedWidget {
    variable w options hull hook forwardlist
    method Create {} {
        variable opt_entry opt_all opt_label opt_org
        set opt_all {-background -borderwidth -cursor -font -foreground -justify -takefocus}
        set opt_entry {-disabledbackground -disabledforeground -exportselection -highlightbackground
                       -highlightcolor -highlightthickness -insertbackground -relief 
                       -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand 
                       -readonlybackground -selectbackground -selectborderwidth -selectforeground
                       -show -state -textvariable -validate -validatecommand -width -xscrollcommand}
        set opt_org {-hook}
        set opt_label {-text}
        label $hull.l
        entry $hull.ent
        button $hull.b -command "$w setfile" -text "..." -relief raise
        set forwardlist [list \
                         $hull.l [concat $opt_all $opt_label]\
                         $hull.b $opt_all \
                         $hull.ent [concat $opt_all $opt_entry] \
                         $w $opt_org]
        $w forwardoption
        pack $hull.l $hull.ent $hull.b -side left
    }
    method configure {optsw val} {
        if {$optsw eq "-hook"} {
            set hook $val
        } else {
            next $optsw $val
        }
    
    }
    method setfile {} {
        set file [tk_getOpenFile -defaultextension .csv -filetypes {{"Text CSV" .csv}}]
        if {$file ne ""} {
            $hull.ent delete 0 end
            $hull.ent insert end $file
            if {$hook ne {}} {
                eval $hook
            }
        }
    }
    method get {} {
        return [$hull.ent get]
    }
    method insert args {
        $hull.ent insert {*}$args
    }
    method delete args {
        $hull.ent delete {*}$args
    }
    method GetSpecs {} {
      return {
        {-text text Text {} {}}
        {-width width Width 20 20}
        {-hook hook Hook {} {}}
        {-borderwidth borderWidth BorderWidth 1 1}
        {-cursor cursor Cursor xterm xterm}
        {-disabledbackground disabledBackground DisabledBackground SystemButtonFace SystemButtonFace}
        {-disabledforeground disabledForeground DisabledForeground SystemDisabledText SystemDisabledText}
        {-exportselection exportSelection ExportSelection 1 1}
        {-font font Font TkTextFont TkTextFont}
        {-foreground foreground Foreground SystemWindowText SystemWindowText}
        {-highlightbackground highlightBackground HighlightBackground SystemButtonFace SystemButtonFace}
        {-highlightcolor highlightColor HighlightColor SystemWindowFrame SystemWindowFrame}
        {-highlightthickness highlightThickness HighlightThickness 0 0}
        {-insertbackground insertBackground Foreground SystemWindowText SystemWindowText}
        {-insertborderwidth insertBorderWidth BorderWidth 0 0}
        {-insertofftime insertOffTime OffTime 300 300}
        {-insertontime insertOnTime OnTime 600 600}
        {-insertwidth insertWidth InsertWidth 2 2}
        {-invalidcommand invalidCommand InvalidCommand {} {}}
        {-justify justify Justify left left}
        {-readonlybackground readonlyBackground ReadonlyBackground SystemButtonFace SystemButtonFace}
        {-relief relief Relief sunken sunken}
        {-selectbackground selectBackground Foreground SystemHighlight SystemHighlight}
        {-selectborderwidth selectBorderWidth BorderWidth 0 0}
        {-selectforeground selectForeground Background SystemHighlightText SystemHighlightText}
        {-show show Show {} {}}
        {-state state State normal normal}
        {-takefocus takeFocus TakeFocus {} {}}
        {-textvariable textVariable Variable {} {}}
        {-validate validate Validate none none}
        {-validatecommand validateCommand ValidateCommand {} {}}
        {-width width Width 20 20}
        {-xscrollcommand xScrollCommand ScrollCommand {} {}}
      }
    }
}
