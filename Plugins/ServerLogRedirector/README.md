@addtogroup serverlogredirector ServerLogRedirector
@page serverlogredirector Readme
@ingroup serverlogredirector 

Redirects server log output to the NWNX logger.

## Environment Variables

| Variable Name | Value | Default | Notes |
| ------------- | :---: | ------- | ----- |
| `NWNX_SERVERLOGREDIRECTOR_HIDE_VALIDATEGFFRESOURCE_MESSAGES` | bool | false | When true, `*** ValidateGFFResource sent by user.` messages are not written to the NWNX log
| `NWNX_SERVERLOGREDIRECTOR_HIDE_EVENT_ADDED_WHILE_PAUSED_MESSAGES` | bool | false | When true, `Event added while paused:  EventId: #   CallerId: #    ObjectId: #` messages are not written to the NWNX log
