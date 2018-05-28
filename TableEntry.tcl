package provide TableEntry 0.1

tk::Megawidget create TableEntry tk::SimpleWidget {
    variable w hull options nrow ncol rowbase
    method GetSpecs {} {
        return {
            {-background background Background SystemWindow SystemWindow}
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
            {-rows rows Rows 10 10}
            {-columns columns Columns 10 10}
            {-labels labels Labels {} {}}
        }
    }
    method Create {} {
        set stdargs {}
        set labels {}
        set nrow 10
        set ncol 10
        foreach {optsw value} [array get options] {
            switch $optsw {
                -rows    {set nrow $value}
                -columns {set ncol $value}
                -labels  {set labels $value}
                default  {lappend stdargs $optsw $value}
            }
        }
        set rowbase 0
        if {$labels ne ""} {
            for {set j 0} {$j < $ncol} {incr j} {
                label $hull.l$j -text [lindex $labels $j]
                grid $hull.l$j -row 0 -column $j
            }
            incr rowbase
        }
        for {set i 0} {$i < $nrow} {incr i} {
            for {set j 0} {$j < $ncol} {incr j} {
                set wid $hull.e${i}_${j}
                eval [concat entry $wid $stdargs]
                grid $wid -row [expr $rowbase+$i] -column $j
            }
        }
    }
    method checkRange {i j} {
        if {$i >= $nrow || $j >= $ncol || $i < 0 || $j < 0} {
            error "Invalid position ($i, $j)"
        }
    }
    method get {i j} {
        $w checkRange $i $j
        return [$hull.e${i}_${j} get]
    }
    method getall {} {
        set res {}
        for {set i 0} {$i < $nrow} {incr i} {
            set dat {}
            for {set j 0} {$j < $ncol} {incr j} {
               lappend dat [$hull.e${i}_${j} get]
            }
            lappend res $dat
        }
        return $res
    }
    method insert {i j args} {
        $w checkRange $i $j
        eval "$hull.e${i}_$j insert $args"
    }
    method nrow {} {return $nrow}
    method ncol {} {return $ncol}
}

