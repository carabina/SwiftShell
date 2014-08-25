//
// Scripts_Tests.swift
// SwiftShell
//
// Created by Kåre Morstøl on 24/08/14.
// Copyright (c) 2014 NotTooBad Software. All rights reserved.
//

import SwiftShell
//import Foundation
import XCTest

class Scripts_Tests: XCTestCase {
	
	let script_folder = "SwiftShellTests/Scripts/"
	
	private func runtestscript ( filename: String) -> String {
		let task = NSTask()
		task.arguments = ["-c",  "echo \"line 1nline 2nline 3\" | ./swiftshell.bash " + script_folder + filename]
		task.launchPath = "/bin/bash"
		
		task.standardInput = NSPipe ()// to avoid implicit reading of the script's standardInput
		// task.standardInput = stream( "line 1\nline 2\nline 3")
		
		let output = NSPipe ()
		task.standardOutput = output
		let error = NSPipe ()
		task.standardError = error

		task.launch()
		task.waitUntilExit()
		
		var errorstring = ""
		switch task {
		case task.terminationStatus != 0 :
			errorstring += ("exit code: \(task.terminationStatus), ")
		case  task.terminationReason == .UncaughtSignal :
			errorstring += ("uncaught signal, ")
		default:
			1
		}
		let standarderror = error.fileHandleForReading.read()
		if !standarderror.isEmpty {
			errorstring += standarderror
		}
		if !errorstring.isEmpty {
			XCTFail("Script \(filename) failed because: \(errorstring)")
		}
		
		return output.fileHandleForReading.read()
		
	}
	
	
	func testExample() {
		print ( runtestscript("print_linenumbers.swift") )
	}
	
}