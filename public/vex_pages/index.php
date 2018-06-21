<!DOCTYPE html>
<!--
    Copyright (c) 2012-2014 Adobe Systems Incorporated. All rights reserved.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
     KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
-->
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <meta name="msapplication-tap-highlight" content="no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <meta http-equiv="Content-Security-Policy"/>

        <link rel="stylesheet" type="text/css" href="css/font-awesome-4.2.0/css/font-awesome.min.css" />
        <link rel="stylesheet" type="text/css" href="js/lib/bootstrap-ios7/css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="js/lib/bootstrap-ios7/css/bootstrap-theme.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css"/>

        <!-- load language -->
        <script type="text/javascript" src="js/lang/lang.pt-BR.js"></script>
        <script type="text/javascript" src="js/lang/lang.en-US.js"></script>

        <!--<script type="text/javascript" src="cordova.js"></script>-->
        <script type="text/javascript" src="js/lib/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="js/lib/moment.js"></script>
        <script type="text/javascript" src="js/lib/bootstrap-ios7/js/bootstrap.js"></script>
        <script type="text/javascript" src="js/lib/tim/tim.js"></script>
        <script type="text/javascript" src="js/lib/fastclick.js"></script>
        <script type="text/javascript" src='js/lib/Swipe-master/swipe.js'></script>
        <!--<script type="text/javascript" src="js/appCore.js"></script>-->
        <!--<script type="text/javascript" src="js/index.js"></script>-->

        <title>Vex Admin</title>

 
    </head>
    <body>
    <nav id="menuNavBar" class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed hide" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span><span id="msgcount1" class="badge badge-notify"></span>
                </button>
                <div id='navbar-backbutton'>
                    <a class="btn-link" id="backLink" href="mobile/close">
                        <span id='backbutton-icon' class='icon icon-2x icon-left'></span>
                        <span id='backbutton-text'>Back</span>
                    </a>
                    <span id="appTile" class="navbar-brand" href="#">The Chateau Menu</span>
                </div>                
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav" id="vex-navbar">
                    <li>
                        <a href="#" data-callback="app.views.chat.list" class="" data-toggle="collapse" data-target=".navbar-collapse">
                            <span id="optChat">Chat</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-callback="app.views.category.init" class="" data-toggle="collapse" data-target=".navbar-collapse">
                            <span id="optCategory">Categorias de Produtos</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-callback="app.views.product.init" class="" data-toggle="collapse" data-target=".navbar-collapse">
                            <span id="optProduct">Produtos</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-callback="app.views.schedule.init" class="" data-toggle="collapse" data-target=".navbar-collapse">
                            <span id="optSchedule">Relatório de Agendamentos</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-callback="app.views.login.logout" class="" data-toggle="collapse" data-target=".navbar-collapse">
                            <span id="optLogout">Log Out</span>
                        </a>
                    </li>
                </ul>   
            </div>
        </div>
    </nav>
        <div id="content" class="container-fluid">
        <iframe 
        <?php
        echo "src=\"https://docs.google.com/gview?embedded=true&url=";
        echo $_GET['link'];
        echo "\"";
        ?>
        style="position: absolute; height: 85%; width: 95%; border: none"></iframe>
        </div>
    </body>
</html>
