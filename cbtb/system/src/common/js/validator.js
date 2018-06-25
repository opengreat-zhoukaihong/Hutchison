/*
	Usage : pageFields = new Array(field_name, "display string", "checkNull|checkEmail|checkNumeric|checkLength,>=2,!=5,<=7|checkRange,<=0,>=0")
*/

//pattern declarations
numericPattern = /\D/
emailPattern = /.*\@.*\..*/

//object definition for validation
function checkField(object, description, criteria) {
	this.object = object
	this.description = description
	this.criteria = criteria
}

//global validation method
function validation(pageFields) {
	var i=0
	var count=0
	var checkFields = new Array(pageFields.length/3);

	do {
		if (typeof(pageFields[i]) == "object") {
			checkFields[count] = new checkField(pageFields[i], pageFields[i+1], pageFields[i+2])
			++count
		}
		i+=3
	} while (i < pageFields.length)

	for (var j = 0; j < checkFields.length; j++) {		
		criteria = checkFields[j].criteria.split("|")
		for (var k = 0; k < criteria.length; k++) {		
			if (criteria[k].toUpperCase() == "CHECKNULL") {
				if (!checkNull(checkFields[j])) {
					return false
				}
			}
			if (criteria[k].toUpperCase() == "CHECKNUMERIC") {
				if (!checkNumeric(checkFields[j])) {
					return false
				}
			}
			if (criteria[k].toUpperCase() == "CHECKPRICE") {
				if (!checkPrice(checkFields[j])) {
					return false
				}
			}

			if (criteria[k].toUpperCase() == "CHECKEMAIL") {
				if (!checkEmailAddress(checkFields[j])) {
					return false
				}
			}
			if (criteria[k].toUpperCase().search("CHECKLENGTH") >= 0) {
				assignmentCheck = criteria[k].split(",")
				if (assignmentCheck[0].toUpperCase() == ("CHECKLENGTH")) {
					if (!checkLength(checkFields[j], assignmentCheck)) {
						return false
					}
				}
			}
			if (criteria[k].toUpperCase().search("CHECKRANGE") >= 0) {
				assignmentCheck = criteria[k].split(",")
				if (assignmentCheck[0].toUpperCase() == ("CHECKRANGE")) {
					if (!checkRange(checkFields[j], assignmentCheck)) {
						return false
					}
				}
			}
		}
	}
	return true
}

function checkNull(pageField) {
	if (pageField.object.value == "") {
		alert(pageField.description + " is required!")
		pageField.object.select()
		pageField.object.focus()
		return false
	}
	return true
}

function checkNumeric(pageField) {
	if (numericPattern.test(pageField.object.value)) {
		alert(pageField.description + " requires a numeric value!")
		pageField.object.select()
		pageField.object.focus()
		return false
	}
	return true
}

function checkPrice(pageField) {
	var fieldValue = pageField.object.value
	var index = pageField.object.value.indexOf('.')

	if (index >= 0) {		
		var str1 = pageField.object.value.substring(0, index)
		var str2 = pageField.object.value.substring(index+1, pageField.object.value.length)
		index = -1
		if (str2.indexOf('.') >= 0) {
			alert("Invalid " + pageField.description + " value!")
			pageField.object.select()
			pageField.object.focus()
			return false
		}
		fieldValue = str1 + str2
	}

	if (numericPattern.test(fieldValue)) {
		alert("Invalid " + pageField.description + " value!")
		pageField.object.select()
		pageField.object.focus()
		return false
	}
	return true
}

function checkEmailAddress(pageField) {
	if (!emailPattern.test(pageField.object.value)) {
		alert("Incorrect " + pageField.description + "!")
		pageField.object.select()
		pageField.object.focus()
		return false
	}
	return true
}

function checkLength(pageField, assignment) {
	var isValidated = new Boolean(true)
	for (var i =1; i < assignment.length; ++i) {
		if (assignment[i].search("<=") >= 0) {
			values = assignment[i].split("<=")
			if (!(pageField.object.value.length <= values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search(">=") >= 0) {
			values = assignment[i].split(">=")
			if (!(pageField.object.value.length >= values[1])) {
				alert(values[1] + "= FALSE")
				isValidated = false
			}		
		} else if (assignment[i].search("!=") >= 0) {
			values = assignment[i].split("!=")
			if (!(pageField.object.value.length != values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search("=") >= 0) {
			values = assignment[i].split("=")
			if (!(pageField.object.value.length == values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search("<") >= 0) {
			values = assignment[i].split("<")
			if (!(pageField.object.value.length < values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search(">") >= 0) {
			values = assignment[i].split(">")
			if (!(pageField.object.value.length > values[1])) {
				isValidated = false
			}		

		}

		if (!isValidated) {
			alert("The length of " + pageField.description + " should be " + assignment[i] + ".")
			pageField.object.select()
			pageField.object.focus()
			return false
		}
	}
	return true
}

function checkRange(pageField, assignment) {
	var isValidated = new Boolean(true)
	for (var i =1; i < assignment.length; ++i) {
		if (assignment[i].search("<=") >= 0) {
			values = assignment[i].split("<=")
			if (!(pageField.object.value <= values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search(">=") >= 0) {
			values = assignment[i].split(">=")
			if (!(pageField.object.value >= values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search("!=") >= 0) {
			values = assignment[i].split("!=")
			if (!(pageField.object.value != values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search("=") >= 0) {
			values = assignment[i].split("=")
			if (!(pageField.object.value == values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search("<") >= 0) {
			values = assignment[i].split("<")
			if (!(pageField.object.value < values[1])) {
				isValidated = false
			}		
		} else if (assignment[i].search(">") >= 0) {
			values = assignment[i].split(">")
			if (!(pageField.object.value > values[1])) {
				isValidated = false
			}		

		}

		if (!isValidated) {
			alert(pageField.description + " should be " + assignment[i] + ".")
			pageField.object.focus()
			pageField.object.select()
			return false
		}
	}
	return true
}