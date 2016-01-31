function initEvents () {
    this.el.on('click', toggleCheck, this, {delegate:'input[type=checkbox]'});
    this.el.on('keyup', completeEdit, this, {delegate:'input[type=text]'});
    this.el.on('click', removeTodo, this, {delegate:'a'});
}
        
function toggleCheck(e, el) {
	var record = this.getRecord(Ext.fly(el).parent('li'));
    record.set('Checked', !record.get('Checked'));
}

function completeEdit(e) {
	var el = Ext.get(e.getTarget());
    var record = this.getRecord(el.parent('li'));            

	if (e.keyCode == 13) {
		var value = el.getValue().trim();

		if (!value) {
			this.store.remove(record);
		} else {
			record.set('Label', value);
			record.set('editing', false);			        
		}
        e.stopEvent();
        return false;
	}
}

function startEdit(view, record) {
    record.set('editing', true);
}

function removeTodo(e) {
    this.store.remove(this.getRecord(Ext.fly(e.getTarget()).parent('li')));
    e.stopEvent();
    return false;
}

function addTodo(field, e) {
	var value = field.getValue().trim();

	if (e.keyCode === 13 && value != '') {
		App.TodoList.store.add({Label: value, Checked: false});
		field.reset();        
        e.stopEvent();
        return false;       
	}
}

function checkAllClick (field, checked) {
	App.TodoList.store.each(function (record) {
		record.set('Checked', checked);
	});
}

function clearAll() {
	var records = [],
		store = App.TodoList.store;

	store.each(function (record) {
		if (record.get('Checked')) {
			records.push(record);
		}
	});
	store.remove(records);
}

function onListChange () {
	var info = '', 
        text = '',
		store = this,
		totalCount = store.getCount(),
        checkbox = App.Checkbox1,
		toolbar = App.Toolbar1,
		button = toolbar.items.last(),
		container = toolbar.items.first(),
		records = store.queryBy(function (record) {
			return !record.get('Checked');
		}),
		count = records.getCount(),
		checkedCount = totalCount - count;

	if (count) {
		info = '<b>' + count + '</b> item' + (count > 1 ? 's' : '') + ' left.';
	}

	if (checkedCount) {
		text = 'Clear '+ checkedCount +' completed item' + (checkedCount > 1 ? 's' : '');
	}

	checkbox.suspendEvents();
    checkbox.setValue(totalCount == checkedCount);
    checkbox.resumeEvents();
    checkbox.setVisible(!!totalCount);
	container.update(info);
	button.setText(text);
	button.setVisible(checkedCount);
	toolbar.setVisible(totalCount);
}