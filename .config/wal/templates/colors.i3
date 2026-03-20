# i3wm colors
set_from_resource $fg i3wm."{color7}" #f0f0f0
set_from_resource $bg i3wm."{color2}" #000000

# class                 border  backgr. text indicator child_border
client.focused          $fg     $fg     $bg  $bg       $fg
client.focused_inactive $bg     $bg     $fg  $bg       $bg
client.unfocused        $bg     $bg     $fg  $bg       $bg
client.urgent           $bg     $bg     $fg  $bg       $bg
client.placeholder      $bg     $bg     $fg  $bg       $bg
client.background       $bg
