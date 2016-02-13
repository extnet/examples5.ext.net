Ext.net.FilterHeader.behaviour.addBehaviour("string", {
    name: "any",

    is : function (value) {
        return Ext.net.StringUtils.startsWith(value, "any ");
    },

    getValue : function (value) {
        var values = Ext.net.FilterHeader.behaviour.getStrValue(value).substring(4).split(","),
            tmp = [];

        Ext.each(values, function(v){
            v = v.trim();
            if(!Ext.isEmpty(v)){
                tmp.push(v);
            }
        });

        values = tmp;

        return {value: values, valid: values.length > 0};
    },

    match : function (recordValue, matchValue) {
        for ( var i = 0; i < matchValue.length; i++ ) {
            if (recordValue === matchValue[i]) {
                return true;
            }
        }

        return false;
    },

    isValid : function (value) {
        return this.getValue(value, field).valid;
    },

    serialize : function (value) {
        return {
            type : "string",
            op: "any",
            value : value
        };
    }
});