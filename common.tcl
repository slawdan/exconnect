proc findSSH {} {
	if {[catch {exec which zssh} zsshbin options]} {
		return [exec which ssh]
    	}	
	return $zsshbin
}

proc checkFileExist {fn func} {
	if { ![file isfile $fn]} {
		send_error "Error: File $fn not exist for $func.\n"
		exit
	}	
}

proc makeFile {fn usage defaultContent} {
	if { [file isfile $fn]} {
		send_user "Using file $fn for $usage.\n"
		return
	}

	send_error "Warning: File $fn not exist, try to create it.\n"

	set f [open $fn "w"]
	puts $f $defaultContent
	close $f
	return
}

proc matchInFile {fn pat} {
	set f [open $fn "r"]
	while 1 {
		if {[gets $f chars] == -1} break
		if {[regexp $pat $chars]} {
			close $f
			return $chars
		} 
	}
	close $f
	return ""
}

proc interactWithFastQuit {} {
	interact {
		!!! {
			set i 0
				send "exit\n"
			while { $i < 10 } {
				expect {
					"'q' to exit" {
						send "q\n"
						break
					}
					-re "\#|\\$" {
						send "exit\n"
					}
					"closed\\." {
						break
					}
					eof {
						break
					}
				}
				incr i
			}
		}
	}
}
