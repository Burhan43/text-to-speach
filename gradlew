package app.cloneprototype;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.accessibilityservice.AccessibilityService;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.PixelFormat;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;


import pub.devrel.easypermissions.EasyPermissions;

import static androidx.core.app.ActivityCompat.startActivityForResult;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "my_tag";
    private TextView tv;
    private Button button,button2;
    private int MY_PERMISSION=1000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
//        startActivity(new Intent(MainActivity.this, Chlo.class));




        Intent intent = new Intent(MainActivity.this, MyService.class);
        intent.putExtra("inputExtra", "Burhan Ahmad");
        ContextCompat.startForegroundService(this, intent);


        tv = findViewById(R.id.textView);
        button = findViewById(R.id.button);
        button2 = findViewById(R.id.button2);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
                startActivity(intent);
            }
        });
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                grantMeAlertWindowPermission();
            }
        });





    }

//    ****to check AlertWindowPermission****


    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        EasyPermissions.onRequestPermissionsResult();
    }

    private void grantMeAlertWindowPermission() {




//        //Check permission
//        if(Build.VERSION.SDK_INT >= 24)
//        {
//            if(!Settings.canDrawOverlays(this))
//            {
//                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
//                intent.setData(Uri.parse("package:" + getPackageName()));
//                startActivityForResult(intent,MY_PERMISSION);
//
//            }
//        }
//        else{
//            Intent intent = new Intent(this, Service.class);
//            startService(intent);
//        }
    }


    @Override
    protected void onResume() {
        super.onResume();
        if(!isAccessibilitySettingsOn(MainActivity.this, MyService.class)) {
            tv.setText(R.string.not_enable);
            button.setText(R.string.enabled);
        }else{
            tv.setText(R.string.is_enabled);
            button.setText(R.string.disabled);
        }
    }


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == MY_PERMISSION) {
            if (Settings.canDrawOverlays(this)) {
                // permission granted...
                Toast.makeText(this, "granted", Toast.LENGTH_SHORT).show();
            } else {
                // permission not granted...
                Toast.makeText(this, "denied", Toast.LENGTH_SHORT).show();
            }
        }
    }

//    public static boolean isAccessibilityServiceEnabled(Context mContext, Class<? extends AccessibilityService> service) {
//        int accessibilityEnabled = 0;
//        final String service = getPackageName() + "/" + MyService.class.getCanonicalName();
//        try {
//            accessibilityEnabled = Settings.Secure.getInt(
//                    mContext.getApplicationContext().getContentResolver(),
//                    android.provider.Settings.Secure.ACCESSIBILITY_ENABLED);
//        } catch (Settings.SettingNotFoundException e) {
//
//        }
//        TextUtils.SimpleStringSplitter mStringColonSplitter = new TextUtils.SimpleStringSplitter(':');
//
//        if (accessibilityEnabled == 1) {
//            String settingValue = Settings.Secure.getString(
//                    mContext.getApplicationContext().getContentResolver(),
//                    Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES);
//            if (settingValue != null) {
//                mStringColonSplitter.setString(settingValue);
//                while (mStringColonSplitter.hasNext()) {
//                    String