"Microsoft Remote Desktop.app/Content/macOS/Microsoft Remote Desktop" --script <module> <parameters>
"Microsoft Remote Desktop.app/Content/macOS/Microsoft Remote Desktop" --script help



--script help

Usage:

  --script <module> <parameters>

  Modules:

    bookmark  Create, edit or delete a connection bookmark.
    feed      Subscribe to a resource feed, or edit or delete a subscription.
    gateway   Create, edit or delete a Remote Desktop gateway.

  To get help for a specific module:

    --script <module> help

  Examples:

    --script bookmark help
    --script feed help
    --script gateway help




--script bookmark help

Create, edit or delete a connection bookmark.

Usage:

  --script bookmark <command> <unique ID> <parameters>

  Commands:

    write   Create or edit a connection bookmark.
    delete  Delete a bookmark.

  To get help for a specific command:

    --script bookmark <command> help

  Examples:

    --script bookmark write help
    --script bookmark delete help




--script bookmark write help

Create or edit a connection bookmark identified by a unique ID.

Usage:

  --script bookmark write <unique ID> <parameters>

  Parameters:

    --hostname <string>
      The hostname of the remote server. This value is required when creating 
      the bookmark.

    --username <string>
      The username to use when connecting to the remote server. A user account 
      will be created if an existing user account could not be found.

    --password <string>
      The password associated with the username.

    --friendlyname <string>
      The friendly name of the bookmark.

    --group <string>
      The name of the group wherein the bookmark resides. A group will be 
      created if an existing one could not be found.

    --gateway <string>
      The unique ID of an existing Remote Desktop gateway. If a gateway with 
      the given ID does not exist, this parameter will be ignored.

    --gatewayhostname <string>
      The hostname of an existing Remote Desktop gateway. If a gateway with 
      the given hostname does not exist, a new one will be created with the 
      given hostname. If multiple gateways exist with the same hostname, the 
      first one will be selected.

    --bypassgateway <true | false>
      If set to true, the Remote Desktop gateway will not be used if the Remote 
      Desktop server is on the same network as the client machine. This 
      parameter is true by default.

    --admin <true | false>
      If set to true, the client will connect to a session that is used for 
      administrative purposes. 

    --swapmousebuttons <true | false>
      If set to true, the left and right mouse buttons are swapped.

    --autoreconnect <true | false>
      If set to true, the client will attempt to automatically reconnect if 
      the connection is interrupted. This parameter is true by default.

    --useallmonitors <true | false>
      If set to true, all the local monitors will be used in the remote 
      session.

    --fullscreen <true | false>
      If set to true, starts the connection in full screen mode (vs windowed 
      mode). This parameter is true by default.

    --scaling <true | false>
      If set to true, the graphics output of the remote session is scaled 
      to fit inside the client window.

    --resolution "<integer integer>"
      The width and height of the remote session in pixels. The width and 
      height must be positive integer values specified as a single string 
      inside quotation marks (for example, "800 600").

    --colordepth <16 | 32>
      The color depth of the remote session in bits per pixel. Allowed 
      values are 16 and 32.

    --retina <true | false>
      If set to true, the graphics output of the remote session is optimized 
      for Retina displays. A value of true is not recommended for connections 
      to versions of Windows prior to Windows 10 and Windows Server 2016.

    --dynamicdisplay <true | false>
      If set to true, the resolution of the remote session is dynamically 
      updated to match the client window size. Dynamic display is only 
      supported by Windows 8.1 and Windows Server 2012 R2 and later.

    --audioplayback <0 | 1 | 2>
      Specifies how to handle audio streams sent by the remote server.
      0: Play the audio on the local computer.
      1: Play the audio on the remote server.
      2: Don't play any audio.
      This parameter is set to 0 by default.

    --redirectmicrophones <true | false>
      If set to true, microphones attached to the computer are redirected to 
      the remote session.

    --redirectprinters <true | false>
      If set to true, printers attached to the computer are redirected to the 
      remote session.

    --redirectfolders <true | false>
      If set to true, selected folders are redirected to the remote session. 
      Due to sandboxing restrictions, users must manually select folders to 
      redirect in the client UI.

   --redirectsmartcards <true | false>
      If set to true, smartcard readers attached to the computer are redirected 
      to the remote session.

    --redirectclipboard <true | false>
      If set to true, the local and remote clipboards are kept in sync. This 
      parameter is true by default.

    --remoteappprogram <string>
      The file path of the remote app executable to launch on the remote server.

    --remoteappcmdline <string>
      Command line parameters to pass to the remote app executable when it is 
      launched on the remote server.

    --remoteappworkingdir <string>
      The working directory assigned to the remote app when it is launched on 
      the remote server.

    --rdpfilecontents <string>
      The contents of an RDP file which should be used to create a bookmark. 
      The "\n" character must be used as a delimiter between properties.

  Examples:

      --script bookmark write 87287 --hostname jumpbox.contoso.com --resolution "1024 768" --fullscreen false --group "Work PCs"
      --script bookmark write 5653454 --rdpfilecontents "full address:s:hostname\ngatewayaccesstoken:s:1234\nenablecredsspsupport:i:0"




--script bookmark delete help

Delete a connection bookmark identified by a unique ID.

Usage:

  --script bookmark delete <unique ID>

  Example:
  
    --script bookmark delete 93568




--script feed help

Subscribe to a resource feed, or edit or delete a subscription.

Usage:

  --script feed <command> <URL> <parameters>

  Commands:

    write   Subscribe to a resource feed or edit a subscription.
    delete  Delete a managed resource feed.

  To get help for a specific command:

    --script feed <command> help

  Examples:

    --script feed write help
    --script feed delete help




--script feed write help

Subscribe to a resource feed or edit a subscription (both specified using a 
feed URL). If a user account is not specified, or if the supplied user 
account is invalid, a stub feed (which can be refreshed via UI) will be 
created with the given URL.

Usage:

  --script feed write <URL> <parameters>
  
  Parameters:
  
    --username <string>
      The username to use when subscribing to the feed. A user account 
      will be created if an existing user account could not be found.
      
    --password <string>
      The password associated with the username.

  Examples:
  
    --script feed write "http://contoso.com/rdweb/feed/webfeed.aspx" --username "manager@contoso.com" --password "S3cr3Tp@$$word"




--script feed delete help

Delete a subscription identified by a feed URL.

Usage:

  --script feed delete <URL>

  Example:
  
    --script feed delete "http://contoso.com/rdweb/feed/webfeed.aspx"




--script gateway help

Create, edit or delete a Remote Desktop gateway.

Usage:

  --script gateway <command> <unique ID> <parameters>

  Commands:

    write   Create or edit a Remote Desktop gateway.
    delete  Delete a Remote Desktop gateway.

  To get help for a specific command:

    --script gateway <command> help

  Examples:

    --script gateway write help
    --script gateway delete help




--script feed write help

Create or edit a Remote Desktop gateway identified by a unique ID.

Usage:

  --script gateway write <unique ID> <parameters>
  
  Parameters:
  
    --hostname <string>
      The hostname of the Remote Desktop gateway. This value is required when 
      creating the gateway.

    --username <string>
      The username to use when connecting to the remote server. A user account 
      will be created if an existing user account could not be found.

    --password <string>
      The password associated with the username.

    --friendlyname <string>
      The friendly name of the Remote Desktop gateway.

  Examples:
  
    --script gateway write 892779 --hostname gw.contoso.com --friendlyname "Contoso Gateway"




--script gateway delete help

Delete a Remote Desktop gateway identified by a unique ID.

Usage:

  --script gateway delete <unique ID>

  Example:
  
    --script bookmark delete 839839