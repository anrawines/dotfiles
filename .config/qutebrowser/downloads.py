# ============================================================================
# DOWNLOADS
# ============================================================================

c.downloads.position = 'bottom'
c.downloads.location.directory = '~/Downloads'
c.downloads.location.suggestion = 'both'
c.downloads.location.prompt = False
c.downloads.remove_finished = 3000

# ============================================================================
# FILE PICKER
# ============================================================================

c.fileselect.handler = 'external'
#c.fileselect.handler = 'default'

# Zenity 
#c.fileselect.single_file.command = ['zenity-dark.sh', '{}']
#c.fileselect.multiple_files.command = ['zenity-dark.sh', '--multiple', '{}']
#c.fileselect.folder.command = ['zenity-dark.sh', '--directory', '{}']

# Ranger
c.fileselect.single_file.command    = ['ranger.sh', '{}']
c.fileselect.multiple_files.command = ['ranger.sh', '--multiple', '{}']
c.fileselect.folder.command         = ['ranger.sh', '--folder', '{}']
