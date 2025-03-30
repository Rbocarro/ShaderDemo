Shader "Unlit/Hologram"
{
    Properties
    {
        _MainTex ("Albedo Texture", 2D) = "white" {}
        _TintColor("Tint Color",Color)=(1,1,1,1)
       _Transparency("Transparency",Range(0.0,1.0))=0.25
       _CutoutTresh("Cutout Treshold",Range(0.0,1.0))=0.2
       _Distance("Distance",Float)=1
       _Ampiltude("Amplitude",float)=1
       _Speed("Speed",float)=1
       _Amount("Amount",float)=1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Zwrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _TintColor;
            float _Transparency;
            float _CutoutTresh;
            float _Distance;
            float _Ampiltude;
            float _Speed;
            float _Amount;
            v2f vert (appdata v)
            {
                v2f o;
               // v.vertex.x+=sin(_Time.y*_Speed+v.vertex.y*_Ampiltude)*_Distance*_Amount;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv)+_TintColor;
                float2 uvs=i.uv;
                uvs.x*=2;
                uvs.x+=_Time.y;
                fixed4 col = fixed4(uvs,0,1);
                col.a=_Transparency;
                fixed4 TextureColor=tex2D(_MainTex,uvs);
                //clip(col.r-_CutoutTresh);
                //clip(col.r*(sin(_Time.y)*_Amount));
                return TextureColor;
                //return col;
            }
            ENDCG
        }
    }
}
