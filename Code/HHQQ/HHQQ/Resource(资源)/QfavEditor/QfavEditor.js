QfavEditor = {};

QfavEditor.E = function() {
    this.__defineGetter__("rootElement", this.getRootElement);
    this.__defineGetter__("changeDisabled", this.getDisableChanged);
}

QfavEditor.E.prototype._ignoredChangeCount = 0;

QfavEditor.E.prototype._noRestoringSelectionOnNextFocus = false;

QfavEditor.E.prototype.getRootElement = function getRootElement() {
    var qfavEditor = document.getElementById("QfavEditor");
    return qfavEditor ? qfavEditor : document.body;
};

QfavEditor.E.prototype.getDisableChanged = function(){
    return this._ignoredChangeCount > 0;
}

QfavEditor.E.prototype._bindEvents = function() {
    this.rootElement.addEventListener('DOMSubtreeModified', this._onDomSubtreeModified, false);
    this.rootElement.addEventListener('focus', this._onFocus, true);
    this.rootElement.addEventListener('focusout', this._onFocusOut, true);
    this.rootElement.addEventListener('touchend', this._onTapEnd, true);
    document.addEventListener("paste", this._onPaste, false);
}

QfavEditor.E.prototype._onDomSubtreeModified = function(e){
    var self = QfavEditor._editor;

    QfavUtil.log('_onDomSubtreeModified _ignoredChangeCount:' + self._ignoredChangeCount);
    
    if (!self.changeDisabled) {
        QfavUtil.notify('domSubtreeModifiedFromJs');
        self.tellSelectionRect(false);
    }
}

QfavEditor.E.prototype._onPaste = function(e) {
    setTimeout(function(){
        QfavUtil.notify('pasteFromJs');
    }, 0);
}

QfavEditor.E.prototype._onFocus = function(e) {
    QfavUtil.log('_onFocus');
    var self = QfavEditor._editor;
    if (!self._noRestoringSelectionOnNextFocus) {
        QfavEditor._editor.restoreSelection();
    } else {
        self._noRestoringSelectionOnNextFocus = false;
    }
}

QfavEditor.E.prototype._onFocusOut = function(e) {
    QfavUtil.log('_onFocusOut');
    QfavEditor._editor.storeCurrentSelection();
}

QfavEditor.E.prototype._onTapEnd = function(e) {
    QfavUtil.log('_onTapEnd');
    QfavEditor._editor.storeCurrentSelection();
}

QfavEditor.E.prototype.ignoreChange = function(igore) {
    if(igore) {
        this._ignoredChangeCount++;
    } else {
        this._ignoredChangeCount--;
    }
}

QfavEditor.E.prototype.getClientSize = function() {
    var eb = document.body;
    var ed = document.documentElement;
    QfavUtil.log('bsw=%d, bow=%d, dcw=%d, dsw=%d, dow=%d', eb.scrollWidth, eb.offsetWidth, ed.clientWidth, ed.scrollWidth, ed.offsetWidth);
    QfavUtil.log('bsh=%d, boh=%d, dch=%d, dsh=%d, doh=%d', eb.scrollHeight, eb.offsetHeight, ed.clientHeight, ed.scrollHeight, ed.offsetHeight);
    QfavUtil.log('root-sw=%d, root-sh=%d', this.rootElement.scrollWidth, this.rootElement.scrollHeight);
    QfavUtil.log('rst=%d, rot=%d, rct=%d, dst=%d, dot=%d', this.rootElement.scrollTop, this.rootElement.offsetTop, this.rootElement.clientTop, ed.scrollTop, ed.offsetTop);
    //var w = Math.max(eb.scrollWidth, eb.offsetWidth, ed.clientWidth, ed.scrollWidth, ed.offsetWidth);
    //var h = Math.max(eb.scrollHeight, eb.offsetHeight, ed.clientHeight, ed.scrollHeight, ed.offsetHeight);
    return {w : this.rootElement.scrollWidth, h : this.rootElement.scrollHeight};
}

QfavEditor.E.prototype.storeCurrentSelection = function storeCurrentSelection() {
    QfavUtil.log('before storeCurrentSelection');
    var sel = window.getSelection();
    if (sel.rangeCount > 0) {
        this._currentRange = sel.getRangeAt(0);
    } else {
        QfavUtil.log('sel.rangeCount == 0');
    }
    QfavUtil.log('after storeCurrentSelection');
};

QfavEditor.E.prototype.restoreSelection = function restoreSelection(invalidateEnd) {
    QfavUtil.log('before restoreSelection');
    var sel = window.getSelection();
    if (this._currentRange) {
        sel.removeAllRanges();
        sel.addRange(this._currentRange);
    }
    QfavUtil.log('after restoreSelection');
};

QfavEditor.E.prototype.getSelectionRect = function (absolute) {
    void(0);
    var sel = window.getSelection();
    var rect = null, bounding = null;

    try {
    	var baseNode = sel.baseNode;
    	var baseOffset = sel.baseOffset;
        var txtLen = baseNode.textContent.length;

        this.ignoreChange(true);

        if (baseNode) {
            if (baseNode.nodeType == Node.TEXT_NODE && txtLen > 0) {
                var charRange = document.createRange();
                if (baseOffset >= txtLen) {
                    baseOffset = txtLen - 1;
                }
                charRange.setStart(baseNode, baseOffset);
                charRange.setEnd(baseNode, baseOffset + 1);
                bounding = charRange.getBoundingClientRect();
                QfavUtil.log('text[' + baseOffset + '] bounding: {' + bounding.left + ',' + bounding.top + ',' + bounding.right + ',' + bounding.bottom + '}');
            } else {
                var child = baseNode;
                if (baseNode.nodeType != Node.ELEMENT_NODE) {
                    child = baseNode.parentElement.lastChild;
                } else if (baseNode.childNodes.length > baseOffset) {
                    child = baseNode.childNodes[baseOffset];
                }
                if (child.getBoundingClientRect) {
                    bounding = child.getBoundingClientRect();
                    QfavUtil.log('node bounding: {' + bounding.left + ',' + bounding.top + ',' + bounding.right + ',' + bounding.bottom + '}');
                } else {
                    rect = {left : child.offsetLeft, top : child.offsetTop, right : child.offsetLeft + child.offsetWidth, bottom : child.offsetTop + child.offsetHeight};
                }
            }
            if (rect == null && bounding) {
                rect = {left : bounding.left + window.scrollX, top : bounding.top + window.scrollY, right : bounding.right + window.scrollX, bottom : bounding.bottom + window.scrollY};
            }
         }

        QfavUtil.log('select baseNode:' + baseNode);
    } catch (e) {
        QfavUtil.log(e.message);
    } finally {
        this.ignoreChange(false);
    }
    
    if(rect) {
        rect = {left : rect.right - 1, top : rect.top, right : rect.right, bottom : rect.bottom};
    }
    
    this.storeCurrentSelection();

    return rect ? rect : {left : 0, top : 0, right : 0, bottom : 0};
};

QfavEditor.E.prototype.caretToBottom = function() {
    var node = this.rootElement.lastChild;
    if (!node) return;
    
    var textNode = null;
    if (node.nodeType == Node.ELEMENT_NODE && node.lastChild && node.lastChild.nodeType == Node.TEXT_NODE) {
        textNode = node.lastChild;
    } else if (node.nodeType == Node.TEXT_NODE) {
        textNode = node;
    }
    
    this.ignoreChange(true);
    var insertNode = false;
    if (!textNode) {
        textNode = document.createTextNode(" ");
        insertNode = true;
        node.appendChild(textNode);
    }
    
    var charRange = document.createRange();
    charRange.setStart(textNode, textNode.textContent.length);
    charRange.setEnd(textNode, textNode.textContent.length);
    this._currentRange = charRange;
    this.restoreSelection();
    if (insertNode) {
        node.removeChild(textNode);
    }
    
    var clientSize = this.getClientSize();
    //window.scrollTo(clientSize.w, clientSize.h);
    this.ignoreChange(false);
    
    this.notifySelectionRect();
}

QfavEditor.E.prototype.notifySelectionRect = function() {
    var clientSize = this.getClientSize();
    QfavUtil.log('begin getClientSize');
    QfavUtil.log(clientSize);
    QfavUtil.log('end getClientSize');
    QfavUtil.log('begin getSelectionRect');
    var selRect = this.getSelectionRect(true);
    QfavUtil.log(selRect);
    QfavUtil.log('end getSelectionRect');
    QfavUtil.notify('selectionRectChangedFromJs', {w : clientSize.w, h : clientSize.h, sl : selRect.left, st : selRect.top,
        sr : selRect.right > clientSize.w ? clientSize.w : selRect.right,
        sb :selRect.bottom > clientSize.h ? clientSize.h : selRect.bottom });
}

QfavEditor.E.prototype.tellSelectionRect = function(sync) {
    if (this._selectionNotifyTimeID) {
        clearTimeout(this._selectionNotifyTimeID);
        this._selectionNotifyTimeID = null;
    }
    if (!sync) {
        var self = this;
        this._selectionNotifyTimeID = setTimeout(function() {self.notifySelectionRect();}, 100);
    } else {
        this.notifySelectionRect();
    }
}

QfavEditor.E.prototype.getInnerHtml = function() {
    return this.rootElement.innerHTML;
}

QfavEditor.E.prototype.getInnerText = function() {
    return this.rootElement.innerText;
}

QfavEditor._editor = new QfavEditor.E();


QfavEditor.start = function() {
    QfavEditor._editor.rootElement.setAttribute("contentEditable", true);
    QfavEditor._editor._bindEvents();
    QfavEditor._editor.rootElement.focus();
    QfavEditor._editor.caretToBottom();
}

QfavEditor.stop = function() {
    QfavEditor._editor.rootElement.blur();
    QfavEditor._editor.rootElement.setAttribute("contentEditable", false);
}

QfavEditor.caretToBottom = function() {
    QfavEditor._editor.caretToBottom();
}

QfavEditor.excuteBridgeCallback = function() {
    QfavUtil.excuteCallback.apply(QfavUtil, [].slice.apply(arguments));
}

QfavEditor.getHtml = function() {
    return QfavEditor._editor.getInnerHtml();
}

QfavEditor.getText = function() {
    return QfavEditor._editor.getInnerText();
}

QfavEditor.insertHTML = function(value) {
    return document.execCommand("insertHTML", false, value);
}

QfavEditor.insertText = function(value) {
    return document.execCommand("insertText", false, value);
}

QfavEditor.setMinHeight = function(value) {
    var minHeight = QfavEditor._editor.rootElement.style.minHeight;
    if (minHeight != value) {
        QfavEditor._editor.rootElement.style.minHeight = value;
    }
}

QfavEditor.delete = function() {
    document.execCommand("delete");
}

QfavEditor.becomeFirstResponder = function(restore) {
    QfavEditor._editor._noRestoringSelectionOnNextFocus = !restore;
    QfavEditor._editor.rootElement.focus();
}

QfavEditor.resignFirstResponder = function() {
    QfavEditor._editor.rootElement.blur();
}

QfavEditor.retellSelectionRect = function() {
    QfavEditor._editor.tellSelectionRect(false);
}
