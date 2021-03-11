RegExGet(hay, needle, options:="", subptr:=0, start:=1) {
	RegExMatch(hay, options "O)" needle, result, start)
	
	if (!result) {
		Return
	} else {
		res := RegExResult(hay, needle, options, subptr, start)
	}
	
	if (!IsObject(subptr)) {
		value := result.value(subptr)
		pos := result.pos(subptr)
		len := result.len(subptr)
		res.add(subptr, value, pos, len)
	} else {
		set := Set(subptr)
		
		for ptr, _ in set.raw {
			pos := result.pos(ptr)
			if (pos == "")
				Continue
			value := result.value(ptr)
			len := result.len(ptr)
			res.add(ptr, value, pos, len)
		}
	}
	
	Return res
}

RegExArray(hay, needle, options:="", subptr:=0, overlap:=false) {
	start := 1
	res := []
	
	Loop {
		result := RegExGet(hay, needle, options, subptr, start)
		if (!result)
			Break
		res.push(result)
		start := result.pos + (overlap ? 1 : result.len)
	}
	
	Return res
}

RegExResult(hay, needle, options, subptr, start:=1) {
	Return new c_RegExResult(hay, needle, options, subptr, start)
}

Class c_RegExResult {
	__New(hay, needle, options, subptr, start) {
		this.type := "regexresult"
		
		this.hay := hay
		this.needle := needle
		this.options := options
		this.subptr := subptr
		this.start := start
		
		this.subpatterns := {}
	}
	
	Add(name, content, pos, len) {
		this.subpatterns[name] := {content: content, pos: pos, len: len}
		this.cache := false
	}
	
	Get(name) {
		Return this.subpatterns[name]
	}
	
	CalculatePosLen() {
		if (!IsObject(this.subptr)) {
			this._pos := this.subpatterns[this.subptr].pos
			this._len := this.subpatterns[this.subptr].len
		} else {
			for name, value in this.subpatterns {
				if (spos == "" || value.pos < spos) {
					spos := value.pos
				}
				
				if (epos == "" || value.pos + value.len - 1 > epos) {
					epos := value.pos + value.len - 1
				}
			}
			
			this._pos := spos
			this._len := epos - spos + 1
		}
		
		this.cache_pos := true
		this.cache_len := true
	}
	
	;---------------------------------------------------------------;
	; Properties
	
	tostring {
		get {
			res := "RegExMatch"
			
			for name, value in this.subpatterns {
				res .= "`n    #" name " I> pos: " value.pos
				res .= " | len: " value.len
				res .= " | content: " value.content
			}
			
			Return res
		}
		set {
		}
	}
	
	content {
		get {
			if (this.cache_content) {
				Return this._content
			}
			
			if (!IsObject(this.subptr)) {
				res := this.subpatterns[this.subptr].content
			} else {
				for i, value in this.subptr {
					res .= this.subpatterns[value].content
				}
			}
			
			this._content := res
			this.cache_content := true
			
			Return res
		}
		set {
		}
	}
	
	data {
		get {
			Return this.subpatterns
		}
		set {
		}
	}
	
	pos {
		get {
			if (this.cache_pos) {
				Return this._pos
			}
			
			this.CalculatePosLen()
			
			Return this._pos
		}
		set {
		}
	}
	
	len {
		get {
			if (this.cache_len) {
				Return this._len
			}
			
			this.CalculatePosLen()
			
			Return this._len
		}
		set {
		}
	}
	
	cache {
		get {
			Return {content: this.cache_content, pos: this.cache_pos, len: this.cache_len}
		}
		set {
			if (!value) {
				this.cache_content := false
				this.cache_pos := false
				this.cache_len := false
			}
		}
	}
}

Set(params*) {
	Return new c_Set(params*)
}

class c_Set {
	__New(params*) {
		this.type := "set"
		this.set := {}
		
		if (IsObject(params[1])) {
			for i, value in params[1] {
				if (value != "") {
					this.add(value)
				}
			}
		} else {
			for i, value in params {
				this.add(value)
			}
		}
	}
	
	Add(item) {
		this.set["" item] := ""
	}
	
	Push(item) {
		this.add(item)
	}
	
	Remove(item) {
		this.set.remove("" item)
	}
	
	Delete(item) {
		this.remove(item)
	}
	
	Contains(item) {
		Return this.set.haskey("" item)
	}
	
	Count() {
		Return this.size
	}
	
	size {
		get {
			Return this.set.count()
		}
		set {
		}
	}
	
	empty {
		get {
			Return this.size == 0
		}
		set {
		}
	}
	
	array {
		get {
			array := []
			for item, _ in this.set {
				array.push(item)
			}
			Return array
		}
		set {
		}
	}
	
	raw {
		get {
			Return this.set
		}
		set {
		}
	}
	
	first {
		get {
			for i,_ in this.set {
				Return i
			}
		}
		set {
		}
	}
	
	last {
		get {
			for i,_ in this.set {
				res := i
			}
			
			Return res
		}
		set {
		}
	}
}