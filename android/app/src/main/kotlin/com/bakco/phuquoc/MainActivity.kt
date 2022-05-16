package com.bakco.phuquoc

import android.app.ActionBar
import android.os.Bundle
import android.view.WindowManager.LayoutParams;
import android.view.WindowManager.LayoutParams.FLAG_SECURE
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        getWindow().addFlags(LayoutParams.FLAG_SECURE);

    }
}
