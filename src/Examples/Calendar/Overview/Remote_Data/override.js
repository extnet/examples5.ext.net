Ext.apply(CompanyX.record, {
    saveAll : function () {
        Ext.net.directRequest({
            url  : "../Shared/Code/RemoteService.asmx/SaveAll",
            json : true,
            cleanRequest : true,
            extraParams  : {
                events : CompanyX.getStore().getRecordsValues()
            }
        });
    }
});