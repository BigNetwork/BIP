Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    
    onReady: function() {
        var tpl = Ext.XTemplate.from('weather');
        
        var makeAjaxRequest = function() {
            Ext.Ajax.request({
                url: 'test.json',
                success: function(response, opts) {
                    Ext.getCmp('content').update(response.responseText);
                    Ext.getCmp('status').setTitle('Static test.json file loaded');
                }
            })
        };
        
        var makeJSONPRequest = function() {
            Ext.util.JSONP.request({
                url: 'http://www.worldweatheronline.com/feed/weather.ashx',
                callbackKey: 'callback',
                params: {                    
                    key: '23f6a0ab24185952101705',
                    // palo alto
                    q: '94301',
                    format: 'json',
                    num_of_days: 5
                },
                callback: function(result) {
                    var weather = result.data.weather;
                    if (weather) {
                        var html = tpl.applyTemplate(weather);
                        Ext.getCmp('content').update(html);                        
                    }
                    else {
                        alert('There was an error retrieving the weather.');
                    }
                    Ext.getCmp('status').setTitle('Palo Alto, CA Weather');
                }
            })
        };
        
		/*
		new Ext.TabPanel({
			fullscreen: true,
			tabBar: {
				dock: 'bottom', 
				ui: 'light', 
				layout: {
					pack: 'center'
				}
			},
            id: 'content',
            ui: 'light', 
			animation: {
				type: 'cardslide', 
				cover: true
			},
			defaults: {
				scroll: 'vertical',
            },
			items: [
				{
	            	title: 'Sök',
					iconCls: 'search',
					html: 'htj',
	            	handler: makeJSONPRequest
	            },
				{
	            	title: 'Inställningar',
					iconCls: 'settings',
	            	handler: makeAjaxRequest			
	            },
				{
	                te: 'status',
	                title: "Tap a button.",
					iconCls: 'info'
	            }
			]
        });
		*/

		
        new Ext.Panel({
            fullscreen: true,
            id: 'content',
            scroll: 'vertical',
            dockedItems: [
				{
	                xtype: 'toolbar',
	                dock: 'bottom',
	                items: [
						{
	                    	text: 'JSONP',
	                    	handler: makeJSONPRequest
	                	},
						{
							xtype: 'spacer'
						},
						{
	                    	text: 'XMLHTTP',
	                    	handler: makeAjaxRequest
						}
					]
	            },
				{
	                id: 'status',
	                xtype: 'toolbar',
	                dock: 'top',
	                title: "Tap a button."
	            }
			]
        })
		
    }
});