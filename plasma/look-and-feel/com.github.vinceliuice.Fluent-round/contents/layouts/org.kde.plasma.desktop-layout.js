var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
            ],
            "config": {
                "/": {
                    "ItemGeometriesHorizontal": "",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/General": {
                    "ToolBoxButtonState": "topcenter",
                    "ToolBoxButtonX": "419"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "file:///home/vince/.local/share/wallpapers/Fluent/contents/images/1920x1080.jpg",
                    "SlidePaths": "/home/vince/.local/share/wallpapers,/usr/share/plasma/wallpapers,/usr/share/wallpapers"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "left",
            "applets": [
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "97"
                        },
                        "/Configuration/General": {
                            "favoritesPortedToKAstats": "true",
                            "systemApplications": "systemsettings.desktop,org.kde.kinfocenter.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        },
                        "/Configuration/General": {
                            "launchers": "applications:github-desktop.desktop,applications:atom.desktop,applications:gnome-system-monitor.desktop,file:///usr/bin/geary?iconData=iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAE-ElEQVRoge2Yy29UVRzHv79z7mM6Ux4tSKENQUQ0EiQuqm5csuAvwB0LN8T4HxhcEEPCwo2BhIgagzGSIInGmNjEhSQsSGoNBQsYRGmntFPsazqvO3PvOb-fi7ZS50GnzG3BZD7JTG7unHvv9ze_57lAmzZt2jxNqIk1amBgYGt_f_9rSil_3RUBYObK0NDQ8JEjR-YBSCv3onQ6_Tozz8gGw8zT6XS6H839yQ3RxpiLGy1-GWPMRQD6cQLVah4A0NvKP9AifVjFA6sZ8MzzvzfAqXfy0Ikze61yDrMxyalcsbeva_NG6wIAZHLF3lfeP_OecpySS_hp-OS7o9Vrajzw1pdX30zt3P2dgI6D1LG5UrlnQ9TWYb4Y9IDUMQEdN37ym0Mf_3Cwek1tCLnqnU17Xn6x76UDuxzttFTC4kApTX7X9i2y9bm-iKOj1b_XhJAjKiUAnK6ern1vdHdmSoZe3RCptQSGZcfze3sKFk4UGSYgVb3m8UnsJfwL42Xv_M3x0rqpbMC1sanCJ79NcEcylXjculWqEIG0qwbz2j85mC5PF8s2TpH1CCJjv7p5P_99Oue6nucQpPU-oBToofj-qZFZvpKeKccjtZb7Mwvlc9fHwozRKVdTc9qavTkRYMlxL2dC79zNicCKtDRkrYRFcHU0U7z416zWvt-h1jD_rK2REUEpR42UncQHgxPR3dlCtGa1VcwVg-jz4dHi4FyU3JTw3bWWvSfqxJqICsrzzt7Lq0u_Tz5xgv86_nfxs9sZLmsv5Tn6iUp2a6OE0vrnLHV8-MtYkKsYbvay0Fj59tZYYSBT8Dt8v6U9RsuzkKs1PZREx6kb03YoM19Zbf34fL5y_sZYeTRUqc0Jv-4osxZiGeYUEQLS7oXxinv2erpouTa_RQRX7k3mv_5jWonrdzhaxdLlY51GiZS6VfGSJwYflCdygVk-X6iE5ovr9_PX5sJkMuG7cT6zZRdW42pFBfESH93JmsPb86U9SYUfxxeU6_udnQ7FPlvFbgAAEBEsaefylNHdjpU9iYSKX_oi62KAFUEutIhYaMIqKlrC_iTDiyfs_0PsO7KKZcyXDaIViZw1guE8MBM9wwaIALnQYiG0qNcQIiHcLQruBQQb3xQSTwhFLMiFBnYVXQLgYUVQMIT9SUJKt25Iyx4IDCNbWV38SooWGClYTIWth1RzHqgjjpcSNazTtJrBiMKfJUHWAi90AN7KxxFJveN6NDRA5NHXv4cQCBFCy8iHFtzaa0sAwGwFyEfAvgShyxWwCEQEIhArvHgMapg1NQYIHlnMgLAImEVYMYGUlEJDQfNzW1NULHCnKNjpCXoTwsZYCa2VyLAYy7JoBASiauxo7AGIMAtFlkUTiwU4sFbFuZGp5kEFyFrCNrE2KIe2FEY2tFYMN47TugYsB45lkdAyWzFkI0W0nA3r9bJFgKwBcnC0a8hkg4oJQsOWGcL1H1vfAwIIAYYFbEVBmIhEaHl_vY4GAICQSEknPeok2NJUnoHFTKhzSW0ORNEEIGBoIqW0AYiWgpAk3thvxGLlEYiXcLt7d2_Nzkzl87lCxBJNVq-t6QOKzekoCudEk8MktFyBRGQxqTfgs1SFIACsUmrzjt4tXd1dC9uM-2m13rrBcODSiJeM5t9W1tsFAIr4qbxi5KWqQ8pM5r0tl24fPRg-DR1t2rRp05h_ANjepTUqlJtMAAAAAElFTkSuQmCC,applications:org.kde.dolphin.desktop,applications:firefox.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icontasks"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "92"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "89"
                        },
                        "/Configuration/Appearance": {
                            "dateFormat": "shortDate",
                            "fontFamily": "Cantarell Light",
                            "showDate": "true",
                            "spinboxHorizontalPercentage": "35",
                            "use24hFormat": "2"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.plasma.splitdigitalclock"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "edgeColor": "#66888888",
                            "size": "5"
                        }
                    },
                    "plugin": "org.kde.plasma.win7showdesktop"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "86",
                    "DialogWidth": "1366"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                }
            },
            "height": 2.3333333333333335,
            "hiding": "normal",
            "location": "bottom",
            "maximumLength": 75.88888888888889,
            "minimumLength": 75.88888888888889,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
